import SwiftUI

// UserProfileView
struct UserProfileView: View {

    @State private var selectedTab = 4 // Set to 4 to make the Profile view the default landing page
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                CommunityFeedView()
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Feed")
                    }
                    .tag(0)

                GroupSessionView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Sessions")
                    }
                    .tag(1)

                AIJulianView()
                    .tabItem {
                        Image(systemName: "brain")
                        Text("Julian")
                    }
                    .tag(2)

                MoodTrackingView()
                    .tabItem {
                        Image(systemName: "waveform.path.ecg")
                        Text("Mood")
                    }
                    .tag(3)

                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
                    .tag(4)
            }
            .accentColor(Color("GentleGreen"))
        }
        .navigationBarHidden(true)
    }
}

// ProfileView
struct ProfileView: View {

    @EnvironmentObject var appState: AppState
    @State var navigateToEditProfile = false // New State variable for navigation
    @State var navigateToSettings = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 5) {
                Text("Hello")
                    .font(.system(size: 48))
                    .multilineTextAlignment(.center)
                    .padding(.top, 28.3465 * 3)
                    .foregroundColor(Color("GentleGreen"))

                NavigationLink(destination: ProfileEditView(), isActive: $navigateToEditProfile, label: {
                    FullWidthButton(title: "Edit Info", action: {
                        navigateToEditProfile = true
                    })
                })

                NavigationLink(destination: SettingsView(), isActive: $navigateToSettings, label: {
                    FullWidthButton(title: "Settings", action: {
                        navigateToSettings = true
                    })
                })

                FullWidthButton(title: "Guide", action: {})
                FullWidthButton(title: "Terms and Conditions", action: {})
                FullWidthButton(title: "Privacy Policy", action: {})
                FullWidthButton(title: "About", action: {})

                Spacer()
                    .frame(height: 20)

                HStack {
                    Button(action: {
                        self.appState.authenticationState = .welcome
                    }) {
                        Text("Log Out")
                            .foregroundColor(Color.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 32)
                    }
                    .background(Color("GentleGreen"))
                    .cornerRadius(15)
                    .padding(.bottom, 10)
                    .padding(.leading, 20)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
    }
}

struct FullWidthButton: View {

    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Color.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(5)
    }
}
