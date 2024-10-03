#if os(iOS)
import SwiftUI
/*import HybridColor*/
/**
 * Preview
 * - Description: This is the preview for the CameraView.
 * - Fixme: add some doc regarding not working in preview etc?
 */
#Preview {
   struct DebugContainer: View {
      @State private var isShowingCamView = false
      // @State private var payload: String = ""
      var body: some View {
         // Your main view content here
         Button("Open Camera") {
            self.isShowingCamView = true
         }
         .sheet(isPresented: $isShowingCamView) {
            CameraView { code in
               print("QR code detected: \(code)")
               // self.payload = detectedPayload
               // print("payload: \(self.payload)")
               self.isShowingCamView = false
            }
         }
      }
   }
   return ZStack {
      Rectangle() // This sets the background color of the app
         .fill(Color.black) /*blackOrWhite*/
         .ignoresSafeArea(.all)
      DebugContainer()
   }
      .environment(\.colorScheme, .dark) // dark / light
}
#endif
