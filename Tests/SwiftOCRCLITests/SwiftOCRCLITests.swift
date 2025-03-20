import XCTest
@testable import SwiftOCRCLI
import AppKit

final class SwiftOCRCLITests: XCTestCase {
    
    /// A small base64 PNG image containing the word "Hello".
    ///
    /// Replace this with a base64 image that reliably produces known results.
    /// This string is just an example and might not perfectly decode to a
    /// testable "Hello" image. Adjust as needed.
    private let sampleBase64 = """
    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
    """
    
    func testBasicTextRecognition() {
        guard let image = loadImage(fromBase64: sampleBase64) else {
            XCTFail("Failed to load image from base64.")
            return
        }
        
        let expectation = XCTestExpectation(description: "Text Recognition")
        
        detectText(in: image, recognitionLanguages: ["en-US"]) { recognizedText in
            XCTAssertNotNil(recognizedText, "No text was recognized.")
            if let text = recognizedText {
                // Check if it contains some substring, e.g. "Hello"
                // In practice, you might just ensure it's non-empty.
                print("Recognized text:", text)
                XCTAssertTrue(text.contains("Hello"), "Recognized text contains 'Hello'.")
                XCTAssertFalse(text.isEmpty, "Recognized text is empty.")
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testGridTextRecognition() {
        guard let image = loadImage(fromBase64: sampleBase64) else {
            XCTFail("Failed to load image from base64.")
            return
        }
        
        let expectation = XCTestExpectation(description: "Grid Text Recognition")
        
        detectcoordinatess(in: image, recognitionLanguages: ["en-US"]) { results in
            XCTAssertNotNil(results, "No results recognized.")
            if let results = results, !results.isEmpty {
                for item in results {
                    XCTAssertFalse(item.text.isEmpty, "Recognized text is empty in grid result.")
                    XCTAssertTrue(item.text.contains("Hello"), "Recognized text contains 'Hello' in grid result.")
                    // The bounding box is normalized, so it should be within [0,1].
                    XCTAssertTrue(item.box.minX >= 0 && item.box.maxX <= 1, "Bounding box X out of range.")
                    XCTAssertTrue(item.box.minY >= 0 && item.box.maxY <= 1, "Bounding box Y out of range.")
                }
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
