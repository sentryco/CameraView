#if os(iOS)
import UIKit
import AVFoundation
/**
 * Extension for CamView that creates the capture session
 * - Note: This extension creates the capture session for the `CamView` class.
 *         To use it, call the createCaptureSession() method to create the capture
 *         session, and add the input and output devices to the session. In a real
 *         world application, you could add support for customizing the behavior of
 *         the capture session, and handling errors and user input.
 */
extension CamView {
   /**
    * Creates the capture session with the default video capture device and metadata output
    * - Description: This method sets up the capture session by configuring the
    *                input device with the default video capture device and the
    *                output device with a metadata output capable of detecting QR
    *                codes. It ensures the app has access to the camera and handles
    *                any errors that may occur during this process, logging them
    *                appropriately.
    * - Note: This function gets an instance of the AVCaptureDevice class to
    *         initialize a device object and provide the video as the media type
    *         parameter. Then, it initializes a `AVCaptureDeviceInput` object using
    *         the previous device object, and sets it as the input device on the
    *         capture session. Finally, it initializes a `AVCaptureMetadataOutput`
    *         object and sets it as the output device to the capture session, sets
    *         the delegate to self, and sets the supported QR code types.
    * - Fixme: ⚠️️ Move the error handling to caller?
    */
   internal func createCaptureSession() {
      guard let captureDevice: AVCaptureDevice = .default(for: .video) else {
         // Logger.error("\(Trace.trace()) - could not get capture device", tag: .ui)
         // promptAlert(title: "Error", msg: "Could not get capture device", primaryText: "Dismiss", secondaryText: nil, primaryHandler: {}, secondaryHandler: nil)
         return
      } // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
      do {
         let input: AVCaptureInput = try AVCaptureDeviceInput(device: captureDevice) // Get an instance of the AVCaptureDeviceInput class using the previous device object.
         captureSession.addInput(input) // Set the input device on the capture session.
      } catch { // This should be called if in simulator mode or if user has not agreed to camera access etc
         // Logger.warn("\(Trace.trace()) - Could not get capture device error: \(error)", tag: .ui) // If any error occurs, simply print it out and don't continue any more.
         // promptAlert(title: "Error", msg: "Could not get capture device error: \(error)", primaryText: "Dismiss", secondaryText: nil, primaryHandler: {}, secondaryHandler: nil)
         return
      }
      // fix: use type bellow
      let output = AVCaptureMetadataOutput() // Initialize a `AVCaptureMetadataOutput` object and set it as the output device to the capture session.
      captureSession.addOutput(output)
      // - Fixme: ⚠️️ weakify the bellow?
      output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main) // Set delegate and use the default dispatch queue to execute the call back
      output.metadataObjectTypes = CamView.supportedCodeTypes // Set supported QR types
   }
}
/**
 * Extension for CamView that creates the QR code frame view and the video preview layer
 * - Note: This extension creates the QR code frame view and the video
 *         preview layer for the CamView class. To use it, call the
 *         createQRCodeFrameView() method to create the QR code frame view,
 *         and the createPreviewLayer() method to create the video preview
 *         layer. In a real world application, you could add support for
 *         customizing the appearance and behavior of the QR code frame view
 *         and the video preview layer, and handling errors and user input.
 */
extension CamView {
   /**
    * Initialize the QR code frame view with a green border
    * - Description: This method creates a UIView with a green border that
    *                visually represents the area where the QR code is detected.
    *                It is overlaid on the camera preview so that users can align
    *                the QR code within the frame for accurate detection.
    * - Returns: The initialized QR code frame view
    */
   internal func createQRCodeFrameView() -> UIView {
      let view: UIView = .init()
      view.layer.borderColor = UIColor.systemGreen.cgColor // Set the border color to green
      view.layer.borderWidth = 2 // Set the border width to 2
      self.addSubview(view) // Add the QR code frame view to the view hierarchy
      self.bringSubviewToFront(view) // Bring the QR code frame view to the front
      return view
   }
   /**
    * Create the video preview layer with the capture session
    * - Description: This method initializes an `AVCaptureVideoPreviewLayer`
    *                with the current capture session. The video preview layer
    *                is configured to fill the aspect of the view it is
    *                contained within. It is then sized to fit the bounds of
    *                the CamView and added to the view's layer hierarchy,
    *                allowing the user to see what the camera is capturing
    *                in real-time.
    * - Returns: The created video preview layer
    */
   internal func createPreviewLayer() -> AVCaptureVideoPreviewLayer {
      let layer = AVCaptureVideoPreviewLayer(session: captureSession)
      layer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Set the video gravity to resizeAspectFill
      let size: CGSize = .init(width: self.layer.bounds.width, height: self.layer.bounds.height)
      layer.frame = .init(origin: self.layer.bounds.origin, size: size) // Set the frame to the bounds of the view
      self.layer.addSublayer(layer) // Add the video preview layer to the view's layer hierarchy
      return layer
   }
}
#endif
