[![Tests](https://github.com/sentryco/CameraView/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/CameraView/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/bdc0d8ab-1d78-42a1-b92d-451cdfd0b111)](https://codebeat.co/projects/github-com-sentryco-cameraview-main)

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
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            print("QR code detected: \(code)")
            self?.dismiss(animated: true)
        }
    }
}

```

## Todo:
- Remove unit-tests
- improve  Error Handling
- improve Asynchronous Operations Handling
- Enhance Error Handling
Currently, error handling is minimal in some parts of the code. It's important to propagate errors appropriately and provide meaningful feedback to users.
```swift
internal func createCaptureSession() throws {
    guard let captureDevice = AVCaptureDevice.default(for: .video) else {
        throw CameraError.captureDeviceNotFound
    }
    do {
        let input = try AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(input)
    } catch {
        throw CameraError.failedToAddInput(error)
    }
    let output = AVCaptureMetadataOutput()
    captureSession.addOutput(output)
    output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
    output.metadataObjectTypes = CamView.supportedCodeTypes
}
enum CameraError: Error {
    case captureDeviceNotFound
    case failedToAddInput(Error)
    case cameraAccessDenied
}
public init(frame: CGRect = .zero, onComplete: @escaping OnComplete = defaultOnComplete) {
    self.onComplete = onComplete
    super.init(frame: frame)
    do {
        try self.createCaptureSession()
    } catch {
        // Handle the error (e.g., show an alert to the user)
        print("Error setting up capture session: \(error)")
    }
    _ = previewLayer
    _ = qrCodeFrameView
    self.accessibilityIdentifier = "cameraView"
}
// Manage Camera Permissions Properly
// Before accessing the camera, check and request the necessary permissions.
internal func createCaptureSession() throws {
    let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
    switch authorizationStatus {
    case .authorized:
        // Proceed with setting up the capture session
        break
    case .notDetermined:
        // Request access
        AVCaptureDevice.requestAccess(for: .video) { granted in
        if granted {
            DispatchQueue.main.async {
                try? self.createCaptureSession()
            }
        } else {
            // Handle denial
            print("Camera access denied by user.")
        }
        }
        return
    case .denied, .restricted:
        throw CameraError.cameraAccessDenied
    @unknown default:
        fatalError("Unknown authorization status")
    }
    // ... rest of the setup code
}
```

- Optimize QR Code Frame Drawing
Consider drawing the QR code frame using the precise corner points for better accuracy.

```swift
if let corners = metadataObj.corners {
    let path = UIBezierPath()
    path.move(to: corners[0])
    for corner in corners.dropFirst() {
        path.addLine(to: corner)
    }
    path.close()
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    shapeLayer.strokeColor = UIColor.systemGreen.cgColor
    shapeLayer.fillColor = UIColor.clear.cgColor
    qrCodeFrameView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    qrCodeFrameView.layer.addSublayer(shapeLayer)
}
```
