#if os(iOS)
import UIKit
/**
 * Lifecycle
 */
extension CamVC {
   /**
    * Lifecycle methods for CamVC - Start
    */
   override public func viewDidLoad() {
      super.viewDidLoad() // Call the superclass's viewDidLoad method
      view = CamView(frame: self.view.frame) // Create camera view
      (view as? CamView)?.onComplete = { payload in // Add callback event listener
         UINotificationFeedbackGenerator().notificationOccurred(.success) // User haptic feedback
         self.onComplete(payload) // Notify external listener
         DispatchQueue.main.async { [weak self] in // Weakify
            self?.dismiss(animated: true, completion: nil) // Dismiss ViewController
         }
      }
      (self.view as? CamView)?.start() // Start the camera
      // - Fixme: ⚠️️ maybe add telemetry here?
   }
   /**
    * End of Lifecycle methods for CamVC
    * - Abstract: This method is called when the view is about to disappear from the screen. 
    * - Description: It stops the camera and calls the superclass's viewWillDisappear method.
    *  - Parameters:
    *   - animated: If true, the disappearance of the view is being animated.
    */
   override public func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated) // Call the superclass's viewWillDisappear method
      (view as? CamView)?.stop() // Stop camera
   }
}
#endif
