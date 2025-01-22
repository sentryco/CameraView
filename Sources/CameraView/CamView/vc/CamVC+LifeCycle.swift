#if os(iOS)
import UIKit
/**
 * Lifecycle
 */
extension CamVC {
   // fixme: add doc
   override public func loadView() {
      let camView = CamView(frame: .zero, onComplete: onComplete)
      view = camView
   }
   // fixme: add doc
   override public func viewDidLoad() {
      super.viewDidLoad()
      (view as? CamView)?.start()
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
