/**
 * Constants used by the CamView class
 * - Note: This extension defines constants for the supported QR code types,
 *         the onComplete closure alias, and the default onComplete callback. In a real
 *         world application, you could add support for customizing these constants to
 *         better suit your needs.
 */
#if os(iOS)
import AVFoundation

extension CamView {
   /**
    * Supported QR code types for the CamView class
    * - Description: This constant array holds the types of QR codes that the
    *                CamView class can process. It includes a variety of common QR
    *                code types such as UPC-E, Code 39, Code 93, Code 128, EAN-8,
    *                EAN-13, Aztec, PDF417, and QR code type.
    * - Note: This array defines the supported QR code types for the `CamView` class. In a real world application, you could add or remove code types from this array to better suit your needs.
    * - SeeAlso: `AVMetadataObject.ObjectType` for more information on the available code types.
    */
   public static var supportedCodeTypes: [AVMetadataObject.ObjectType] = [
      .upce, // UPC-E code type
      .code39, // Code 39 code type
      .code39Mod43, // Code 39 Mod 43 code type
      .code93, // Code 93 code type
      .code128, // Code 128 code type
      .ean8, // EAN-8 code type
      .ean13, // EAN-13 code type
      .aztec, // Aztec code type
      .pdf417, // PDF417 code type
      .qr // QR code type
   ]
   /**
    * Closure alias for when a QR code is captured
    * - Description: This closure is invoked when a QR code is successfully
    *                captured by the CamView. The payload parameter contains the
    *                data encoded in the QR code.
    * - Parameters:
    *   - payload: The payload of the captured QR code
    */
   public typealias OnComplete = (_ payload: String) -> Void
   /**
    * Default "on-complete" callback if the caller hasn't set a callback
    * - Note: This callback simply prints a message to the console. In a real
    *         world application, you could replace this with a more meaningful callback.
    */
   public static var defaultOnComplete: OnComplete = { payload in
      Swift.print("default onComplete - QR Code detected: \(payload)")
   }
}
#endif
