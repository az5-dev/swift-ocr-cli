import Foundation
import AppKit

#if os(macOS)
import Vision

// MARK: - CLI Entry Point
let arguments = CommandLine.arguments

guard arguments.count > 1 else {
    print("Usage: \(arguments[0]) <imageFilePath or base64String> [recognitionLanguages] [--coordinate] [--json]")
    print("Example: \(arguments[0]) /path/to/image.jpg ko-KR,en-US --coordinate --json")
    exit(1)
}

let input = arguments[1]
var image: NSImage?

// Attempt to load from file path; if it doesn't exist, treat input as base64
if FileManager.default.fileExists(atPath: input) {
    image = loadImage(fromFilePath: input)
} else {
    image = loadImage(fromBase64: input)
}

guard let nsImage = image else {
    print("Could not load image from the given input.")
    exit(1)
}

// If the second argument is not a flag, assume it's a list of languages
let recognitionLanguages: [String]
if arguments.count > 2, !arguments[2].hasPrefix("--") {
    recognitionLanguages = arguments[2].split(separator: ",").map { String($0) }
} else {
    recognitionLanguages = ["en-US"]
}

let coordinateMode = arguments.contains("--coordinate")
let jsonMode = arguments.contains("--json")

// Use a semaphore to wait for the async completion
let semaphore = DispatchSemaphore(value: 0)

if coordinateMode {
    detectcoordinatess(in: nsImage, recognitionLanguages: recognitionLanguages) { results in
        guard let results = results, !results.isEmpty else {
            if jsonMode {
                let dict: [String: Any] = [
                    "text": "",
                    "cordinates": []
                ]
                if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            } else {
                print("No text recognized.")
            }
            semaphore.signal()
            return
        }
        
        // Combine all recognized text lines
        let plainText = results.map { $0.text }.joined(separator: "\n")
        
        // Convert bounding boxes from normalized coordinates to actual pixel values
        let imageWidth = nsImage.size.width
        let imageHeight = nsImage.size.height
        
        // Create an array of dictionaries describing bounding boxes and text
        let coordinateArray: [[String: Any]] = results.map { result in
            let normalizedBox = result.box
            let pixelX = normalizedBox.origin.x * imageWidth
            let pixelY = (1 - normalizedBox.origin.y - normalizedBox.size.height) * imageHeight
            let pixelWidth = normalizedBox.size.width * imageWidth
            let pixelHeight = normalizedBox.size.height * imageHeight
            
            return [
                "coordinate": [
                    "x": pixelX,
                    "y": pixelY,
                    "width": pixelWidth,
                    "height": pixelHeight
                ],
                "text": result.text
            ]
        }
        
        if jsonMode {
            let dict: [String: Any] = [
                "text": plainText,
                "coordinates": coordinateArray
            ]
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } else {
            print("Recognized text:\n\(plainText)\n")
            print("GRID info:")
            for item in coordinateArray {
                print(item)
            }
        }
        semaphore.signal()
    }
} else {
    detectText(in: nsImage, recognitionLanguages: recognitionLanguages) { recognizedText in
        let text = recognizedText ?? ""
        if jsonMode {
            let dict: [String: Any] = ["text": text]
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } else {
            print("Recognized text:\n\(text)")
        }
        semaphore.signal()
    }
}

// Wait until OCR completes
_ = semaphore.wait(timeout: .distantFuture)

#else
// This CLI tool only supports macOS, because it relies on Vision + AppKit
fatalError("swift-ocr-cli is supported only on macOS.")
#endif
