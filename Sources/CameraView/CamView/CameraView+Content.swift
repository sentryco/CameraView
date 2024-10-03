#if os(iOS)
import SwiftUI
/**
 * Content
 */
extension CameraView {
   /**
    * Initialize the view controller
    * - Description: Creates and configures a new instance of the CamVC view controller for use with SwiftUI.
    * - Parameter context: The context in which the view controller is being created
    * - Returns: The initialized view controller
    */
   public func makeUIViewController(context: Context) -> CamVC {
      // Dispatches a block to the main queue asynchronously to perform UI-related operations
      DispatchQueue.main.async {
         // Initializes a new instance of CamVC
         let vc = CamVC()
         // Sets the onComplete closure for the view controller to print the payload to the console
         vc.onComplete = { payload in Swift.print("payload:  \(payload)") }
      }
      // Initializes a new instance of CamVC outside of the dispatch block
      let viewController = CamVC()
      // Sets the onComplete closure for the view controller to either the provided closure or a default error handler
      viewController.onComplete = onComplete ?? { _ in Swift.print("err") }
      // Returns the view controller instance
      return viewController
   }
   /**
    * Reactive vc
    * - Description: This method is called to update the view controller with the latest state.
    * - fixme: Consider removing or retaining as boilerplate for contract compliance?
    * - Parameters:
    *   - uiViewController: The view controller to be updated
    *   - context: The context in which the view controller is being updated
    */
   public func updateUIViewController(_ uiViewController: CamVC, context: Context) {
      // Update the view controller if needed
   }
}
#endif
