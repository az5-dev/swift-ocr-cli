import Foundation
import AppKit
import Vision

// MARK: - Text-only recognition
public func detectText(
    in image: NSImage,
    recognitionLanguages: [String],
    completion: @escaping (String?) -> Void
) {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        completion(nil)
        return
    }
    
    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("Error occurred during text recognition: \(error)")
            completion(nil)
            return
        }
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            completion(nil)
            return
        }
        // Collect recognized text
        let recognizedStrings = observations.compactMap {
            $0.topCandidates(1).first?.string
        }
        let resultText = recognizedStrings.joined(separator: "\n")
        completion(resultText)
    }
    
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    request.recognitionLanguages = recognitionLanguages
    
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    do {
        try handler.perform([request])
    } catch {
        print("Failed to perform text recognition: \(error)")
        completion(nil)
    }
}

// MARK: - Text recognition with coordinates (GRID mode)
public func detectcoordinatess(
    in image: NSImage,
    recognitionLanguages: [String],
    completion: @escaping ([(text: String, box: CGRect)]?) -> Void
) {
    guard let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
        completion(nil)
        return
    }
    
    let request = VNRecognizeTextRequest { request, error in
        if let error = error {
            print("Error occurred during text recognition: \(error)")
            completion(nil)
            return
        }
        guard let observations = request.results as? [VNRecognizedTextObservation] else {
            completion(nil)
            return
        }
        
        let results: [(text: String, box: CGRect)] = observations.compactMap { observation in
            guard let candidate = observation.topCandidates(1).first else { return nil }
            return (candidate.string, observation.boundingBox)
        }
        completion(results)
    }
    
    request.recognitionLevel = .accurate
    request.usesLanguageCorrection = true
    request.recognitionLanguages = recognitionLanguages
    
    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
    do {
        try handler.perform([request])
    } catch {
        print("Failed to perform text recognition: \(error)")
        completion(nil)
    }
}

// MARK: - Image loading
public func loadImage(fromFilePath path: String) -> NSImage? {
    return NSImage(contentsOfFile: path)
}

public func loadImage(fromBase64 base64String: String) -> NSImage? {
    // If the base64 string contains a data URL prefix, remove everything before the comma
    let cleanedString: String
    if let commaIndex = base64String.firstIndex(of: ",") {
        cleanedString = String(base64String.suffix(from: base64String.index(after: commaIndex)))
    } else {
        cleanedString = base64String
    }
    guard let imageData = Data(base64Encoded: cleanedString) else {
        return nil
    }
    return NSImage(data: imageData)
}
