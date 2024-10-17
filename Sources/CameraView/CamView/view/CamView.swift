#if os(iOS)
import UIKit
import AVFoundation
/**
 * Camera view to capture QR code
 * - Abstract: A view that captures QR codes using the device's camera
 * - Description: The CamView class is a custom UIView that utilizes the device's
 *                camera to capture and process QR codes. It provides a simple
 *                interface for starting and stopping the camera, and delivers the
 *                captured QR code data through a callback function. This class is
 *                designed to be easy to integrate into any iOS application that
 *                requires QR code scanning functionality.
 * - Note: This view provides a simple way to capture QR codes using the device's camera. To use it, create a new instance of CamView with the desired frame, add it to your view hierarchy, and set the onComplete callback to handle the captured payload. Then, call the start() method to start capturing QR codes. In a real world application, you could add support for customizing the appearance and behavior of the view, and handling errors and user input.
 * ## Examples:
 * let camView = CamView.init(frame: self.view.frame)
 * view.addSubview(camView)
 * view.onComplete = { payload in Swift.print("payload:  \(payload)") }
 * camView.start()
 */
public final class CamView: UIView, AVCaptureMetadataOutputObjectsDelegate {
   internal lazy var previewLayer: AVCaptureVideoPreviewLayer = createPreviewLayer() // video layer
   internal lazy var qrCodeFrameView: UIView = createQRCodeFrameView() // Basically holds the green outline where the qr is located
   internal lazy var captureSession: AVCaptureSession = .init() // Video logic
   public var onComplete: OnComplete = defaultOnComplete // caputure completion callback
   /**
    * Initializes a new instance of CamView with the specified frame and onComplete callback
    * - Description: This initializer is used to create a new instance of CamView.
    *                It sets up the camera view with the specified frame size and sets
    *                the callback function to be called when a QR code is captured.
    *                The callback function receives the payload of the captured QR
    *                code as its parameter.
    * - Parameters:
    *   - frame: The size of the camera view
    *   - onComplete: The callback for when a QR code is captured
    * - Note: This function sets the onComplete callback to the specified
    *         callback, calls the designated initializer of the superclass
    *         with the specified frame, creates the capture session,
    *         initializes the video preview layer and adds it as a sublayer
    *         to the view's layer, creates the QR code frame view, and sets
    *         the accessibility identifier of the view for UI testing. In a
    *         real world application, you could add support for customizing
    *         the appearance and behavior of the view, and handling errors
    *         and user input.
    * - Fixme: ⚠️️ Move the accessibilityIdentifier constant to CommonLib, or keep it here?
    */
   public init(frame: CGRect = .zero, onComplete: @escaping OnComplete = defaultOnComplete) {
      self.onComplete = onComplete // Set the onComplete callback to the specified callback
      super.init(frame: frame) // Call the designated initializer of the superclass with the specified frame
      self.createCaptureSession() // Create the capture session
      _ = previewLayer // Initialize the video preview layer and add it as a sublayer to the view's layer
      _ = qrCodeFrameView // Create the QR code frame view
      self.accessibilityIdentifier = "cameraView" // Set the accessibility identifier of the view for UI testing
   }
   /**
    * Boilerplate
    */
   @available(*, unavailable)
   required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
#endif
