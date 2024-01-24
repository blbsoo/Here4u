import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            switch appState.authenticationState {
            case .welcome:
                WelcomeView()
            case .login:
                LoginView()
            case .signUp:
                SignUpView()
            case .forgotPassword:
                ForgotPasswordView()
            case .authenticated:  // Add this case
                CommunityFeedView()  // Or whatever your main authenticated view is
            }
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
        .navigationBarHidden(true) // Hide the navigation bar
    }
}
