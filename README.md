# swift-ocr-cli

**swift-ocr-cli** is a Swift command-line tool that leverages Apple's [Vision](https://developer.apple.com/documentation/vision) framework (macOS only) to perform Optical Character Recognition (OCR) on images. This tool supports multiple input methods and output formats, making it flexible for various use cases.


![](./docs/images/test.png)

```bash
$ swift-ocr-cli-arm-mac ./docs/images/test.png ko,en --json
{
  "text" : "[EPA 및 DHA 함유 유지] 혈중 중성지질 개선\n• 혈행 개선에 도움을 줄 수 있음, 기억력 개선\n에 동장에 도수 있 수 건조한 눈을 개선하여\n[비타민트 항산화 작용을 하여 유해산소로부터\n세포를 보호하는데 필요\n1일 섭취량 : 1캡슐(1,200 mg)\n1일 섭취량 당\n함량\n%영양성분기준치\n열량\n10 kcal\n탄수화물\n0 g\n단백질\n지방\n0 g\n1.2 g\n나트륨\n0 mg\nEPA 와 DHA의 합 900 mg\n비타민E\n3.4 mg a-TE\n0 %\n0 %\n2%\n0 %\n31 %\n※ %영양성분기준치 : 1일 영양성분기준치에 대한 비율"
}
```

```
$ swift-ocr-cli-arm-mac ./docs/images/test.png ko,en --json --coordinate
```

<details>
<summary>Output</summary>

```json
{
  "text" : "[EPA 및 DHA 함유 유지] 혈중 중성지질 개선\n• 혈행 개선에 도움을 줄 수 있음, 기억력 개선\n에 동장에 도수 있 수 건조한 눈을 개선하여\n[비타민트 항산화 작용을 하여 유해산소로부터\n세포를 보호하는데 필요\n1일 섭취량 : 1캡슐(1,200 mg)\n1일 섭취량 당\n함량\n%영양성분기준치\n열량\n10 kcal\n탄수화물\n0 g\n단백질\n지방\n0 g\n1.2 g\n나트륨\n0 mg\nEPA 와 DHA의 합 900 mg\n비타민E\n3.4 mg a-TE\n0 %\n0 %\n2%\n0 %\n31 %\n※ %영양성분기준치 : 1일 영양성분기준치에 대한 비율",
  "results" : [
    {
      "confidence" : 0.90000000000000002,
      "height" : 13.500000000000004,
      "text" : "[EPA 및 DHA 함유 유지] 혈중 중성지질 개선",
      "width" : 205.5,
      "coordinate" : {
        "y" : 18.000000104999991,
        "x" : 13.499997945000032
      }
    },
    {
      "confidence" : 0.90000000000000002,
      "coordinate" : {
        "y" : 31.50000007500001,
        "x" : 17.999997506250068
      },
      "text" : "• 혈행 개선에 도움을 줄 수 있음, 기억력 개선",
      "width" : 199.5,
      "height" : 11.999999999999982
    },
    {
      "confidence" : 0.90000000000000002,
      "width" : 205.875,
      "text" : "에 동장에 도수 있 수 건조한 눈을 개선하여",
      "height" : 27.000000000000007,
      "coordinate" : {
        "y" : 38.999999774999999,
        "x" : 17.999999774999992
      }
    },
    {
      "coordinate" : {
        "x" : 15.000001457142845,
        "y" : 65.999999924999997
      },
      "text" : "[비타민트 항산화 작용을 하여 유해산소로부터",
      "height" : 13.500000000000004,
      "width" : 204,
      "confidence" : 0.90000000000000002
    },
    {
      "confidence" : 0.90000000000000002,
      "coordinate" : {
        "x" : 16.50000043124999,
        "y" : 78.000000168750006
      },
      "width" : 106.5,
      "text" : "세포를 보호하는데 필요",
      "height" : 13.500000000000004
    },
    {
      "confidence" : 0.90000000000000002,
      "coordinate" : {
        "x" : 15.000001229999976,
        "y" : 91.500000135000022
      },
      "text" : "1일 섭취량 : 1캡슐(1,200 mg)",
      "height" : 13.499999999999977,
      "width" : 132
    },
    {
      "height" : 14.144134998321526,
      "confidence" : 0.90000000000000002,
      "text" : "1일 섭취량 당",
      "coordinate" : {
        "y" : 102.42793259372162,
        "x" : 14.813497974876295
      },
      "width" : 63.373003005981438
    },
    {
      "width" : 22.500000000000007,
      "coordinate" : {
        "y" : 101.99999986875002,
        "x" : 112.50000028124998
      },
      "height" : 13.500000000000004,
      "confidence" : 0.90000000000000002,
      "text" : "함량"
    },
    {
      "confidence" : 0.90000000000000002,
      "height" : 12.000000000000009,
      "coordinate" : {
        "y" : 103.5000000642857,
        "x" : 142.49999945357143
      },
      "text" : "%영양성분기준치",
      "width" : 76.500000000000014
    },
    {
      "text" : "열량",
      "height" : 13.500000000000004,
      "width" : 24,
      "coordinate" : {
        "y" : 120.00000013499999,
        "x" : 14.999999970000005
      },
      "confidence" : 0.90000000000000002
    },
    {
      "text" : "10 kcal",
      "coordinate" : {
        "x" : 104.99999942500003,
        "y" : 120.00000002499999
      },
      "height" : 10.499999999999988,
      "width" : 34.499999999999993,
      "confidence" : 0.90000000000000002
    },
    {
      "confidence" : 0.90000000000000002,
      "height" : 13.500000000000004,
      "coordinate" : {
        "x" : 16.499999710714292,
        "y" : 132.00000007499997
      },
      "width" : 40.5,
      "text" : "탄수화물"
    },
    {
      "height" : 10.499999999999988,
      "confidence" : 0.90000000000000002,
      "text" : "0 g",
      "coordinate" : {
        "x" : 114.00000029999998,
        "y" : 133.49999997500001
      },
      "width" : 18.000000000000011
    },
    {
      "width" : 31.499999999999993,
      "coordinate" : {
        "x" : 16.500000314999994,
        "y" : 145.499999925
      },
      "height" : 13.500000000000004,
      "text" : "단백질",
      "confidence" : 0.90000000000000002
    },
    {
      "text" : "지방",
      "height" : 14.999999999999998,
      "confidence" : 0.90000000000000002,
      "width" : 22.5,
      "coordinate" : {
        "x" : 14.999999835000002,
        "y" : 157.49999985000002
      }
    },
    {
      "width" : 18.000000000000011,
      "coordinate" : {
        "y" : 145.49999994999999,
        "x" : 114.00000029999998
      },
      "height" : 12.000000000000009,
      "text" : "0 g",
      "confidence" : 0.90000000000000002
    },
    {
      "text" : "1.2 g",
      "width" : 25.500000000000007,
      "coordinate" : {
        "x" : 109.50000025499999,
        "y" : 158.99999995500002
      },
      "height" : 13.500000000000004,
      "confidence" : 0.90000000000000002
    },
    {
      "height" : 13.500000000000004,
      "confidence" : 0.90000000000000002,
      "text" : "나트륨",
      "coordinate" : {
        "x" : 14.999999725000004,
        "y" : 171.00000006249999
      },
      "width" : 33
    },
    {
      "coordinate" : {
        "x" : 111.00000019999999,
        "y" : 172.49999993750004
      },
      "text" : "0 mg",
      "confidence" : 0.90000000000000002,
      "width" : 24.000000000000007,
      "height" : 10.499999999999988
    },
    {
      "text" : "EPA 와 DHA의 합 900 mg",
      "coordinate" : {
        "y" : 182.99999985000002,
        "x" : 15.000000239999999
      },
      "width" : 126,
      "height" : 14.999999999999998,
      "confidence" : 0.90000000000000002
    },
    {
      "text" : "비타민E",
      "width" : 39,
      "height" : 13.499999999999977,
      "confidence" : 0.90000000000000002,
      "coordinate" : {
        "x" : 16.500000324999995,
        "y" : 196.49999993749998
      }
    },
    {
      "height" : 14.424535274505601,
      "coordinate" : {
        "y" : 196.03773258809812,
        "x" : 92.901844003049078
      },
      "text" : "3.4 mg a-TE",
      "width" : 61.69631195068358,
      "confidence" : 0.90000000000000002
    },
    {
      "height" : 13.500000000000004,
      "text" : "0 %",
      "width" : 20.999999999999996,
      "coordinate" : {
        "x" : 199.50000026250001,
        "y" : 131.99999990625
      },
      "confidence" : 0.90000000000000002
    },
    {
      "text" : "0 %",
      "coordinate" : {
        "y" : 145.500000075,
        "x" : 199.49999983750001
      },
      "height" : 12.000000000000009,
      "confidence" : 0.90000000000000002,
      "width" : 19.499999999999996
    },
    {
      "text" : "2%",
      "width" : 20.999999999999996,
      "coordinate" : {
        "x" : 199.50000021,
        "y" : 157.49999992499997
      },
      "confidence" : 0.90000000000000002,
      "height" : 13.500000000000004
    },
    {
      "text" : "0 %",
      "height" : 13.500000000000004,
      "width" : 20.999999999999996,
      "confidence" : 0.90000000000000002,
      "coordinate" : {
        "x" : 199.50000026250001,
        "y" : 170.99999990625003
      }
    },
    {
      "confidence" : 0.90000000000000002,
      "text" : "31 %",
      "height" : 15.000000000000023,
      "width" : 25.499999999999993,
      "coordinate" : {
        "y" : 196.50000018749998,
        "x" : 195.00000028125001
      }
    },
    {
      "text" : "※ %영양성분기준치 : 1일 영양성분기준치에 대한 비율",
      "width" : 205.5,
      "confidence" : 0.90000000000000002,
      "height" : 14.999999999999998,
      "coordinate" : {
        "x" : 15.000000581249971,
        "y" : 212.99999981250002
      }
    }
  ]
}
```

</details>


---

## Features

- **Multiple Input Forms:**  
  Accepts either an image file path or a base64-encoded image string.

- **Output Formats:**  
  - **Plain Text:** Simply outputs the recognized text.  
  - **JSON Format:** Use the `--json` flag to receive results in JSON.

- **Coordinates Mode:**  
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
