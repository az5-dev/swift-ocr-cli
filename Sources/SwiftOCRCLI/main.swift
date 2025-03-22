import Foundation
import AppKit

#if os(macOS)
import Vision

// MARK: - CLI Entry Point
// This command-line tool performs OCR on an input image.
// It accepts an image file path or a base64 encoded image string as the first argument.
// Optionally, you can provide a comma-separated list of recognition languages, 
// the "--coordinate" flag to include coordinate data, and the "--json" flag for JSON output.
// Example: swift-ocr-cli /path/to/image.jpg ko-KR,en-US --coordinate --json

// Retrieve command line arguments.
let arguments = CommandLine.arguments
// Define the version
let VERSION = "1.0.1"
let HELP = """
    Usage: \(arguments[0]) <imageFilePath or base64String> [recognitionLanguages] [--coordinate] [--json]

    Options:
        --help                Show this help message and exit.
        --version             Show version info.
        recognitionLanguages  Comma-separated list of languages (default: en-US)
        --coordinate          Include coordinate data (bounding boxes) in the output.
        --json                Output the OCR result in JSON format instead of plain text.

    Returns:
        - Outputs plain text recognized from the image.
        - With --json:
            • Without --coordinate: JSON object with key "text".
            • With --coordinate: JSON object containing "text", "coordinate".
"""

// Check for version flag
if arguments.count > 1 && arguments[1] == "--version" {
    print(VERSION)
    exit(0)
}

// Check for help flag
if arguments.count > 1 && arguments[1] == "--help" {
    print(HELP)
    exit(0)
}

// Ensure that at least one argument is provided.
guard arguments.count > 1 else {
    print("Usage: \(arguments[0]) <imageFilePath or base64String> [recognitionLanguages] [--coordinate] [--json]")
    print("Example: \(arguments[0]) /path/to/image.jpg ko-KR,en-US --coordinate --json")
    print("       : \(arguments[0]) --version")
    exit(1)
}

// The first argument is the input, which can be a file path or a base64 string.
let input = arguments[1]
var image: NSImage?

// Attempt to load the image from a file path; if the file does not exist, treat the input as a base64 string.
if FileManager.default.fileExists(atPath: input) {
    image = loadImage(fromFilePath: input)
} else {
    image = loadImage(fromBase64: input)
}

// Verify that the image was successfully loaded.
guard let nsImage = image else {
    print("Could not load image from the given input.")
    exit(1)
}

// Determine the recognition languages.
// If the second argument exists and does not start with "--", treat it as a comma-separated list of languages.
// Otherwise, default to English ("en-US").
let recognitionLanguages: [String]
if arguments.count > 2, !arguments[2].hasPrefix("--") {
    recognitionLanguages = arguments[2].split(separator: ",").map { String($0) }
} else {
    recognitionLanguages = ["en-US"]
}

// Check for the presence of the "--coordinate" and "--json" flags.
let coordinateMode = arguments.contains("--coordinate")
let jsonMode = arguments.contains("--json")

// Create a semaphore to wait for the asynchronous OCR process to complete.
let semaphore = DispatchSemaphore(value: 0)

if coordinateMode {
    // Perform OCR with coordinate detection.
    // The 'detectcoordinate' function is assumed to asynchronously detect text blocks along with their bounding boxes.
    detectcoordinate(in: nsImage, recognitionLanguages: recognitionLanguages) { results in
        // If no results are returned, output an empty JSON or a plain text message.
        guard let results = results, !results.isEmpty else {
            if jsonMode {
                // Output an empty JSON structure.
                let dict: [String: Any] = [
                    "text": "",
                    "coordinates": []
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
        
        // Combine all recognized text lines into one string for the plain text output.
        let plainText = results.map { $0.text }.joined(separator: "\n")
        
        // Get the image dimensions to convert normalized bounding box coordinates into pixel values.
        let imageWidth = nsImage.size.width
        let imageHeight = nsImage.size.height
        
        // Create an array of dictionaries with the new format for each OCR result.
        // Each dictionary includes:
        //   - "text": The recognized text.
        //   - "width": The bounding box width in pixels.
        //   - "height": The bounding box height in pixels.
        //   - "confidence": A default confidence value (0.9).
        //   - "coordinate": A dictionary containing the "x" and "y" pixel coordinates (top-left of the bounding box).
        let resultArray: [[String: Any]] = results.map { result in
            let normalizedBox = result.box
            let pixelX = normalizedBox.origin.x * imageWidth
            let pixelY = (1 - normalizedBox.origin.y - normalizedBox.size.height) * imageHeight
            let pixelWidth = normalizedBox.size.width * imageWidth
            let pixelHeight = normalizedBox.size.height * imageHeight
            
            // Use a default confidence value of 0.9.
            let confidence = 0.9
            
            return [
                "text": result.text,
                "width": pixelWidth,
                "height": pixelHeight,
                "confidence": confidence,
                "coordinate": [
                    "x": pixelX,
                    "y": pixelY
                ]
            ]
        }
        
        // Output the OCR results in either JSON or plain text format.
        if jsonMode {
            // If there is a single result, output it as a standalone JSON object.
            // Otherwise, wrap the results along with combined text in a JSON dictionary.
            if resultArray.count == 1, let singleResult = resultArray.first,
               let jsonData = try? JSONSerialization.data(withJSONObject: singleResult, options: [.prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            } else {
                let dict: [String: Any] = [
                    "text": plainText,
                    "coordinates": resultArray
                ]
                if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                }
            }
        } else {
            // For plain text output, print the combined recognized text and details for each result.
            for item in resultArray {
                print(item)
            }
        }
        semaphore.signal()
    }
} else {
    // Perform OCR without coordinate details.
    // The 'detectText' function is assumed to asynchronously detect text in the image.
    detectText(in: nsImage, recognitionLanguages: recognitionLanguages) { recognizedText in
        let text = recognizedText ?? ""
        if jsonMode {
            let dict: [String: Any] = ["text": text]
            if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted]),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
        } else {
            print("\(text)")
        }
        semaphore.signal()
    }
}

// Wait until the OCR process completes.
_ = semaphore.wait(timeout: .distantFuture)

#else
// This CLI tool only supports macOS because it relies on the Vision and AppKit frameworks.
fatalError("swift-ocr-cli is supported only on macOS.")
#endif
