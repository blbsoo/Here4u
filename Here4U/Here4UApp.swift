import SwiftUI

@main
struct siBusApp: App {
   @StateObject var appState = AppState()

   init() {
       print("Initializing AppState object...")
       let appearance = UITabBar.appearance()
       appearance.barTintColor = UIColor.white
       appearance.isTranslucent = false
   }

   var body: some Scene {
       WindowGroup {
           ContentView().environmentObject(appState)
       }
   }
    struct YourApp: App {
        var body: some Scene {
            WindowGroup {
                CommunityFeedView()
            }
        }
    }
}


