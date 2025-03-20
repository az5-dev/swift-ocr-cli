// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "swift-ocr-cli",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "swift-ocr-cli",
            targets: ["SwiftOCRCLI"]
        )
    ],
    dependencies: [

    ],
    targets: [
        .executableTarget(
            name: "SwiftOCRCLI",
            dependencies: [],
            path: "Sources/SwiftOCRCLI"
        ),
        .testTarget(
            name: "SwiftOCRCLITests",
            dependencies: ["SwiftOCRCLI"],
            path: "Tests/SwiftOCRCLITests"
        )
    ]
)
