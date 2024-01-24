import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var isEmailValid: Bool = true
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color("SoftBlue").edgesIgnoringSafeArea(.all) // Background color

            VStack(spacing: 15) {
                // Spacer to push content down
                Spacer()
                    .frame(height: 150) // Adjusted height (tripled)

                // Description
                Text("Enter your email to reset password")
                    .font(.system(size: UIFont.preferredFont(forTextStyle: .subheadline).pointSize * 0)) // 1.5 times the subheadline size
                    .padding(.horizontal)
                    .foregroundColor(Color("GentleGreen"))
                    .bold()

                // Email Field
                HStack {
                    Image(systemName: "envelope.fill") // Email Icon
                        .foregroundColor(.gray)
                    TextField("Email", text: $email)
                        .autocapitalization(.none) // No auto capitalization
                        .keyboardType(.emailAddress) // Email keyboard
                }
                .padding()
                .background(Color(.white)) // Use UIColor.white
                .cornerRadius(18)
                .padding(.horizontal)
                .onChange(of: email) { newValue in
                    // Validate email on change
                    isEmailValid = newValue.isValidEmail()
                }

                // Warning for invalid email
                if !isEmailValid {
                    Text("Please enter a valid email")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // Reset Password Button
                Button(action: {
                    // Reset Password Action
                }) {
                    Text("Reset Password")
                        .font(.custom("Open Sans", size: 18))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color("GentleGreen"))
                        .cornerRadius(25)
                }
                .padding(.top, 20)
                .disabled(!isEmailValid) // Disable button if email is invalid

                Spacer()
            }
            .padding()

            // Custom Go Back Button placed over other views
            customBackButton
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true) // Hide the navigation bar
        .navigationBarBackButtonHidden(true) // Hide the back button
    }

    // Custom back button view
    var customBackButton: some View {
        VStack {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left") // Arrow Icon
                        .font(.system(size: 16, weight: .bold)) // Set the size
                        .foregroundColor(.white) // White color
                        .padding(15) // Padding around the arrow
                        .background(Color("GentleGreen")) // Gentle Green background
                        .cornerRadius(25) // Rounded corners
                }
                .padding(.leading) // Padding to position the button

                Spacer() // Push the button to the left
            }
            .padding(.top, 30) // Padding to move button up

            Spacer()
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
