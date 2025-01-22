#if os(iOS)
import UIKit
import AVFoundation
extension CamView {
  /**
   * Extension for CamView that handles metadata output from the capture session
   * - Description: This method is called when the AVCaptureMetadataOutput
   *                object outputs metadata objects. It checks if any of the
   *                metadata objects are of a supported QR code type. If so,
   *                it updates the QR code frame view to highlight the QR
   *                code's location and calls the onComplete closure with
   *                the QR code's content.
   * - Remark: There are other output methods as well such as `captureOutput`
   * - Fixme: ⚠️️ The ideal way to create `qrCodeFrameView` frame is to get the points of the QR and draw lines, still relevant?
   * fixme: doc each line
   * - Parameters:
   *   - output: The capture output object
   *   - metadataObjects: An array of metadata objects that contains information about the detected QR codes
   *   - connection: The capture connection object
   * - Note: This extension handles metadata output from the capture session and detects QR codes in the captured video. If a supported QR code is detected, it updates the QR code frame view and calls the onComplete closure with the string value of the captured QR code. In a real world application, you could add support for customizing the behavior of the QR code detection, and handling errors and user input.
   */
   public func metadataOutput(
      _ output: AVCaptureMetadataOutput,
      didOutput metadataObjects: [AVMetadataObject],
      from connection: AVCaptureConnection
   ) {
      // ⚠️️ was recently refactored to use one guard etc
      guard 
         let metadataObj = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
         CamView.supportedCodeTypes.contains(metadataObj.type),
         let barCodeObject = previewLayer.transformedMetadataObject(for: metadataObj),
         let stringValue = metadataObj.stringValue 
      else {
         qrCodeFrameView.frame = .zero
         return
      }
      qrCodeFrameView.frame = barCodeObject.bounds
      DispatchQueue.main.async { [weak self] in
         self?.onComplete(stringValue)
      }
   }
}
#endif
