import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("SoftBlue").edgesIgnoringSafeArea(.all)

                VStack {
                    // Define a specific width for the buttons
                                let buttonWidth: CGFloat = 200
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.75)
                        .padding(.top, UIScreen.main.bounds.height * -0.02)

                    Text("Welcome to Here4U")
                        .font(.title)
                  
                        
                        .foregroundColor(Color("darkerblue"))
                        .padding(.top, 0)
               

                    NavigationLink(destination: LoginView()) {
                                   Text("Login")
                                       .font(.custom("Open Sans", size: 20))
                                       .foregroundColor(.white)
                                       .padding(15)
                                       .frame(width: buttonWidth) // Apply specific width
                                       .background(Color("GentleGreen"))
                                       .cornerRadius(25)
                    }
                        .padding(.top, 20)
                  
                              

                     NavigationLink(destination: SignUpView()) {
                                   Text("Sign Up")
                                       .font(.custom("Open Sans", size: 20))
                                       .foregroundColor(.white)
                                       .padding(15)
                                       .frame(width: buttonWidth) // Apply specific width
                                       .background(Color("GentleGreen"))
                                       .cornerRadius(25)
                    }
                    .padding(.top, 7)

                    Link(destination: URL(string: "https://www.your-privacy-policy-url.com")!) {
                        Text("Privacy Policy & Terms")
                            .font(.custom("Open Sans", size: 14))
                            .background(Color("darkblue"))
                            .italic()
                            .underline()
                    }
                    .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
