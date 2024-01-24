import SwiftUI

struct ProfileEditView: View {
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedAge: Int? = nil
    @State private var selectedGender: String? = nil
    
    @State private var db = DatabaseHelper.sharedInstance // Add this line for DatabaseHelper
    
    let ageRange = [nil] + Array(0...99).map { $0 }
    let genders = [nil, "Male", "Female", "Others"] as [String?]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                Spacer()
                
                Text("EDIT INFO")
                    .font(.system(size: 34, weight: .medium, design: .default))
                    .padding(.bottom, 20)
                    .foregroundColor(Color("GentleGreen"))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
                
                // Name
                Group {
                    Text("Name")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                }

                // Email
                Group {
                    Text("Email")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    TextField("Enter your email", text: $email)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                }

                // Password
                Group {
                    Text("Password")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                    
                    SecureField("Enter your password", text: $password)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.white, lineWidth: 1))
                }

                // Age picker
                Picker("Age", selection: $selectedAge) {
                    Text("Select Your Age").tag(nil as Int?)
                    ForEach(ageRange.dropFirst(), id: \.self) { age in
                        Text("\(age!)").tag(age as Int?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(Color("GentleGreen"))

                // Gender picker
                Picker("Gender", selection: $selectedGender) {
                    Text("Select Your Gender").tag(nil as String?)
                    ForEach(genders.dropFirst(), id: \.self) { gender in
                        Text("\(gender!)").tag(gender as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accentColor(Color("GentleGreen"))
                
                // Confirm button
                Button(action: {
                    // Handle confirm action here
                    saveUserDetails()
                }) {
                    Text("Confirm")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("GentleGreen"))
                        .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .onAppear() {
            if let users = db.getAllUsers() {
                for user in users {
                    print("User ID: \(user.id), Username: \(user.username), Password: \(user.password)")
                }
            }
        }
    }
    
    // Function to save user details to database
    // Function to save user details to database
    private func saveUserDetails() {
        if let id = db.addUser(username: name, password: password, age: selectedAge, gender: selectedGender) {
            print("User added with ID: \(id)")
        } else {
            print("Failed to add user.")
        }
    }

}


