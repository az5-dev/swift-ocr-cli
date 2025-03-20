# swift-ocr-cli

**swift-ocr-cli** is a Swift command-line tool that leverages Apple's [Vision](https://developer.apple.com/documentation/vision) framework (macOS only) to perform Optical Character Recognition (OCR) on images. This tool supports multiple input methods and output formats, making it flexible for various use cases.

---

## Features

- **Multiple Input Forms:**  
  Accepts either an image file path or a base64-encoded image string.

- **Output Formats:**  
  - **Plain Text:** Simply outputs the recognized text.  
  - **JSON Format:** Use the `--json` flag to receive results in JSON.

- **Grid Mode:**  
  Use the `--coordinate` flag to get recognized text along with bounding box coordinates.  
  The output includes:
  - Recognized text.
  - Bounding box dimensions (`width` and `height`).
  - A default confidence score.
  - Pixel coordinates (`x`, `y`) for the top-left corner of the bounding box.

---

## Requirements

- **macOS:** Version 10.15 or later
- **Xcode:** Version 13 or later (to build Swift tools using Vision)
- **Swift:** Version 5.5 or later

---

## Build & Run

### Cloning the Repository

Clone the repository and change to the project directory:

```bash
git clone <REPO_URL> swift-ocr-cli
cd swift-ocr-cli
```

### Building the Tool

Build the project using Swift Package Manager:

```bash
swift build
```

### Running the Tool

Run the tool with the following syntax:

```bash
swift run swift-ocr-cli <imageFilePath or base64Str> [recognitionLanguages] [--coordinate] [--json]
```

#### Example Usages

1. **Basic Text Recognition (defaults to English):**

    ```bash
    swift run swift-ocr-cli /path/to/image.jpg
    ```

2. **Specifying Custom Recognition Languages:**

    ```bash
    swift run swift-ocr-cli /path/to/image.jpg ko-KR,en-US
    ```

3. **Coordinate Mode with JSON Output:**

    ```bash
    swift run swift-ocr-cli /path/to/image.jpg --coordinate --json
    ```

4. **Using Base64 Input:**

    ```bash
    swift run swift-ocr-cli <base64EncodedImageString> --coordinate
    ```

---

## Release Instructions

To build release versions for different architectures, use the provided scripts.

### Running the Release Script

```bash
./scripts/release.sh
```

### Manual Build Commands

- **For arm64:**

    ```bash
    swift build -c release --arch arm64 --build-path .build/arm64
    ```

- **For x86_64:**

    ```bash
    swift build -c release --arch x86_64 --build-path .build/x86_64
    ```

---

## Testing

A sample test is included which uses a base64-encoded image. Run the tests with:

```bash
swift test
```

---

## License

[Apache License Version 2.0](./LICENSE)
