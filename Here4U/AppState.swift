import SwiftUI

class AppState: ObservableObject {
    @Published var authenticationState: AuthenticationState = .welcome
}

enum AuthenticationState {
    case welcome
    case login
    case signUp
    case forgotPassword
    case authenticated  // Add this
}
