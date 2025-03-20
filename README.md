# swift-ocr-cli

A Swift command-line tool that uses Apple's [Vision](https://developer.apple.com/documentation/vision) framework (macOS only) to recognize text (OCR) from images.  

**Features**:
1. **Multiple input forms**: Provide an image file path or a base64-encoded string.
2. **Multiple output formats**: Plain text or JSON (via `--json`).
3. **Grid mode**: Retrieve recognized text with bounding box coordinates.

## Requirements

- macOS 10.15 or later
- Xcode 13 or later (to build Swift tools and use Vision)
- Swift 5.5 or later

## Build & Run

1. **Clone** and **enter** the directory:
    ```bash
    git clone <REPO_URL> swift-ocr-cli
    cd swift-ocr-cli
    ```
2. **Build**:
    ```bash
    swift build
    ```
3. **Run**:
    ```bash
    swift run swift-ocr-cli <imageFilePath or base64String> [recognitionLanguages] [--coordinate] [--json]
    ```
### Examples

1. **Basic text recognition** (defaults to `["en-US"]`):
    ```bash
    swift run swift-ocr-cli /path/to/image.jpg
    ```
2. **Custom languages**:
    ```bash
    swift run swift-ocr-cli /path/to/image.jpg ko-KR,en-US
    ```
3. **Grid mode with JSON**:
    ```bash
    swift run swift-ocr-cli /path/to/image.jpg --coordinate --json
    ```
4. **Base64 input**:
    ```bash
    swift run swift-ocr-cli <base64EncodedImageString> --coordinate
    ```

## Release

```bash
# arm64
swift build -c release --arch arm64 --build-path .build/arm64

# x86_64
swift build -c release --arch x86_64 --build-path .build/x86_64
```

## Testing

A sample test is included using a base64-encoded image. Run tests using:
```bash
swift test
```