#if os(iOS)
import UIKit
/**
 * `ViewController` used to capture QR-code for iOS
 * ## Examples:
 * DispatchQueue.main.async {
 *    let vc = CamVC()
 *    vc.onComplete = { payload in Swift.print("payload:  \(payload)") }
 *    vc.modalTransitionStyle = .coverVertical
 *    vc.modalPresentationStyle = .popover
 *    self.parentViewController?.present(vc, animated: true, completion: nil)
 * }
 */
public final class CamVC: UIViewController {
   /**
    * Callback when a capture is returned
    * - Fixme: ⚠️️⚠️️ Add result style payload and error handling. See https://github.com/keepassium/KeePassium/blob/master/KeePassium/util/QRCodeScanner.swift for an example.
    */
   public var onComplete: OnComplete = defaultOnComplete
   /**
    * Initializes a new instance of the `CamVC` class.
    * - Parameter onComplete: The closure to be called when a capture is returned
    */
   public init(onComplete: @escaping OnComplete = defaultOnComplete) {
      self.onComplete = onComplete // Set the onComplete closure
      super.init(nibName: nil, bundle: nil) // Call the superclass's initializer
   }
   /**
    * Required initializer that is not implemented.
    */
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
#endif
