#if os(iOS)
import UIKit
/**
 * Callback related
 */
extension CamVC {
   /**
    * A closure that takes a payload string and returns void.
    * - Parameter payload: The string payload passed to the closure.
    */
   public typealias OnComplete = (_ payload: String) -> Void
   /**
    * The default `OnComplete` closure that prints the payload to the console.
    */
   public static let defaultOnComplete: OnComplete = { (_ payload: String) in
      Swift.print("default onComplete: \(payload)")
   }
}
#endif
