import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isEmailValid: Bool = true // Added for validation
    @State private var isPasswordValid: Bool = true // Added for validation
    @State private var showForgotPassword = false
    @Environment(\.presentationMode) var presentationMode
    let buttonWidth: CGFloat = 200  // Define the button width here
        
    let textFieldWidth: CGFloat = 350

    var body: some View {
        ZStack {
            Color("SoftBlue").edgesIgnoringSafeArea(.all) // Background color

            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 150) // Adjusted height to push content down

                Text("Log in here")
                    .font(.custom("Open Sans", size: 34))
                    .foregroundColor(Color("GentleGreen")) 
            

                TextFieldWithIcon(iconName: "envelope.fill", placeholder: "Email", text: $email, isPasswordVisible: .constant(false), width: textFieldWidth)
                    .onChange(of: email) { newValue in
                        isEmailValid = newValue.isValidEmail()
                    }

                if !isEmailValid {
                    Text("Please enter a valid email")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                TextFieldWithIcon(iconName: "lock.fill", placeholder: "Password", text: $password, isSecure: !isPasswordVisible, isPasswordVisible: $isPasswordVisible, width: textFieldWidth)
                    .onChange(of: password) { newValue in
                        isPasswordValid = newValue.isValidPassword()
                    }

                if !isPasswordValid {
                    Text("Password must be at least 8 characters")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                NavigationLink(destination: UserProfileView()) {
                    Text("Login")
                        .font(.custom("Open Sans", size: 20))
                        .foregroundColor(.white)
                        .padding(18)
                        .frame(width: buttonWidth) // Apply specific width
                        .background(Color("GentleGreen"))
                        .cornerRadius(25)
                }

                .disabled(!(isEmailValid && isPasswordValid)) // Disable if invalid

                // Other buttons and links
                NavigationLink("", destination: ForgotPasswordView(), isActive: $showForgotPassword)
                Button(action: { self.showForgotPassword = true }) {
                    Text("Forgot Password?")
                        .font(.custom("Open Sans", size: 15))
                        .background(Color("darkblue"))
                        .italic()
                        .underline()
                }
                NavigationLink("Or Sign Up", destination: SignUpView())
                    .background(Color("darkblue"))

               
            }
            .padding()

            // Custom Go Back Button placed over other views
            customBackButton
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true) // Hide the navigation bar
    }

    var customBackButton: some View {
        VStack {
            HStack {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left") // Arrow Icon
                        .font(.system(size: 16, weight: .bold)) // Set the size
                        .foregroundColor(.white) // White color
                        .padding(15) // Padding around the arrow
                        .background(Color("GentleGreen")) // Gentle Green background
                        .cornerRadius(25)
                }
                .padding(.leading) // Padding to position the button
                
                Spacer() // Push the button to the left
            }
            .padding(.top, 30) // Padding to move button up

            Spacer()
        }
    }

    struct TextFieldWithIcon: View {
        let iconName: String
        let placeholder: String
        @Binding var text: String
        var isSecure: Bool = false
        @Binding var isPasswordVisible: Bool
        let width: CGFloat // Add width parameter

        var body: some View {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.gray)
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
                if isSecure {
                    Button(action: { isPasswordVisible.toggle() }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .frame(width: width) // Apply the specific width
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

