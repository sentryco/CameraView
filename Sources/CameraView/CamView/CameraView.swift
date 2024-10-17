#if os(iOS)
import SwiftUI
import AVFoundation
import UIKit
/**
 * CamView uikit - swiftui bridge
 * - Description: A SwiftUI view that acts as a bridge to a UIKit UIViewController
 *                for displaying a camera interface on iOS. It allows capturing
 *                photos or videos and provides a completion handler to process
 *                the captured media.
 * - Fixme: ⚠️️ Maybe there is a way to use this in SwiftUI as well. do research etc
 */
public struct CameraView: UIViewControllerRepresentable {
   /**
    * - Description: This is the typealias for the closure that is passed to the `onComplete` parameter.
    * - Parameters:
    *   - result: The string result of the operation.
    */
   public typealias OnComplete = (_ result: String) -> Void
   /**
    * - Description: This is the closure that is passed to the `onComplete` parameter.
    */
   public var onComplete: OnComplete?
   /**
    * - Parameter onComplete: The closure to be called when the camera view completes its operation. It takes a string parameter representing the result of the operation.
    */
   public init(onComplete: OnComplete? = nil) {
      self.onComplete = onComplete
   }
}
#endif
