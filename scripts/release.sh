#!/usr/bin/env bash

set -e

# 1) Build for ARM64 (Apple Silicon)
swift build -c release --arch arm64 --build-path .build/arm64
# Copy and rename to .build/swift-ocr-cli-arm-mac
cp .build/arm64/release/swift-ocr-cli .build/swift-ocr-cli-arm-mac

# 2) Build for x86_64 (Intel)
swift build -c release --arch x86_64 --build-path .build/x86_64
# Copy and rename to .build/swift-ocr-cli-intel-mac
cp .build/x86_64/release/swift-ocr-cli .build/swift-ocr-cli-intel-mac

echo "Done! Check .build/ for swift-ocr-cli-arm-mac and swift-ocr-cli-intel-mac."
