#if os(iOS)
import Foundation
/**
 * Extension for CamView that provides methods for starting and stopping video capture
 * - Note: This extension provides a simple way to start and stop video
 *         capture using the capture session. To use it, call the start()
 *         method to start capturing video, and the stop() method to stop
 *         capturing video. In a real world application, you could add
 *         support for customizing the behavior of the capture session, and
 *         handling errors and user input.
 */
extension CamView {
   /**
    * Start video capture by starting the capture session
    * - Description: This method initiates the video capture process by
    *                starting the capture session. It should be called when you want to
    *                start capturing video, such as when the user navigates to the camera
    *                view or the application enters the foreground.
    */
   public func start() {
      captureSession.startRunning() // This line starts the capture session, beginning the video capture process.
   }
   /**
    * Stop video capture by stopping the capture session
    * - Description: This method stops the video capture process by halting
    *                the capture session. It should be called when you no longer
    *                need to capture video, such as when the user navigates away
    *                from the camera view or the application enters the background.
    */
   public func stop() {
      captureSession.stopRunning() // This line stops the capture session, ending the video capture process.
   }
}
#endif
