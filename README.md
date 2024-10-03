# CameraView

Simple CameraView to capture QR-codes for SwiftUI.

## Features

- **SwiftUI Integration**: Easily integrate with SwiftUI projects.
- **QR Code Scanning**: Efficiently capture QR codes using the device's camera.
- **Customizable**: Extend and customize behaviors to fit your needs.

## Requirements

- iOS 17.0+

## Installation

### Swift Package Manager

You can add `CameraView` to your project via Swift Package Manager. Add the following to your `Package.swift` file:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "YourPackageName",
    products: [
        // Define products here
    ],
    dependencies: [
        .package(
            url: "https://github.com/sentryco/CameraView",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "CameraView",
            dependencies: []
        )
    ]
)
```

## Usage

To use `CameraView`, import the package and then instantiate `CameraView` in your SwiftUI views:

```swift
import SwiftUI
import CameraView

struct ContentView: View {
    var body: some View {
        CameraView { (_ code: String) in
            print("QR code detected: \(code)")
        }
    }
}
```

## License `CameraView` is available under the MIT license. See the LICENSE file for more info.  

