#if os(iOS)
import UIKit
import AVFoundation
extension CamView {
  /**
   * Extension for CamView that handles metadata output from the capture session
   * - Description: This method is called when the AVCaptureMetadataOutput object outputs metadata objects. It checks if any of the metadata objects are of a supported QR code type. If so, it updates the QR code frame view to highlight the QR code's location and calls the onComplete closure with the QR code's content.
   * - Remark: There are other output methods as well such as `captureOutput`
   * - Fixme: ⚠️️ The ideal way to create `qrCodeFrameView` frame is to get the points of the QR and draw lines, still relevant?
   * - Parameters:
   *   - output: The capture output object
   *   - metadataObjects: An array of metadata objects that contains information about the detected QR codes
   *   - connection: The capture connection object
   * - Note: This extension handles metadata output from the capture session and detects QR codes in the captured video. If a supported QR code is detected, it updates the QR code frame view and calls the onComplete closure with the string value of the captured QR code. In a real world application, you could add support for customizing the behavior of the QR code detection, and handling errors and user input.
   */
   public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
      guard !metadataObjects.isEmpty else { // Check if the metadataObjects array is not nil and it contains at least one object.
         qrCodeFrameView.frame = .zero // Resets the QR code frame view to have no size and position when no QR code is detected.
         return // No QR / bar-code is detected, bail-out
      }
      if let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject, // Get the metadata object
         // Check if the found metadata is a supported QR code type
         CamView.supportedCodeTypes.contains(metadataObj.type) {
         guard let barCodeObject: AVMetadataObject = previewLayer.transformedMetadataObject(for: metadataObj) else {
             return // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
         }
         qrCodeFrameView.frame = barCodeObject.bounds // Basically the green outline where the QR is at
         if let stringValue = metadataObj.stringValue { // Found QR, that has string payload
            self.onComplete(stringValue) // Call the onComplete closure with the string value of the captured QR code
         }
      }
   }
}
#endif
