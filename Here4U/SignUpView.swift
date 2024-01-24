import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var isEmailValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var doPasswordsMatch: Bool = true
    @Environment(\.presentationMode) var presentationMode

    let textFieldWidth: CGFloat = 350

    var customBackButton: some View {
        VStack {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color("GentleGreen"))
                        .cornerRadius(25)
                }
                .padding(.top, 30)
                .padding(.leading)
                Spacer()
            }
            Spacer()
        }
    }

    var body: some View {
        ZStack {
            Color("SoftBlue").edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(spacing: 20) {
                    customBackButton
                    Spacer()
                        .frame(height: 150)
                    Text("Sign up here")
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

                    TextFieldWithIcon(iconName: "lock.fill", placeholder: "Confirm Password", text: $confirmPassword, isSecure: !isConfirmPasswordVisible, isPasswordVisible: $isConfirmPasswordVisible, width: textFieldWidth)
                        .onChange(of: confirmPassword) { newValue in
                            doPasswordsMatch = password.passwordsMatch(newValue)
                        }

                    if !doPasswordsMatch {
                        Text("Passwords do not match")
                            .font(.footnote)
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        // Sign Up Action
                    }) {
                        Text("Sign Up")
                            .font(.custom("Open Sans", size: 20))
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color("GentleGreen"))
                            .cornerRadius(25)
                    }
                    .disabled(!(isEmailValid && isPasswordValid && doPasswordsMatch))
                    
                   
                }
                NavigationLink("ALready have an account? Log in", destination: LoginView())
                    .foregroundColor(Color("GentleGreen")) 
                    .font(.custom("Open Sans", size: 15))
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }

    struct TextFieldWithIcon: View {
        let iconName: String
        let placeholder: String
        @Binding var text: String
        var isSecure: Bool = false
        @Binding var isPasswordVisible: Bool
        let width: CGFloat

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
            .frame(width: width)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


