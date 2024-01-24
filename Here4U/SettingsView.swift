import SwiftUI

struct SettingsView: View {
    
    @State private var selectedLanguage: String? = nil
    @State private var pushNotificationsEnabled: Bool = true
    @State private var remindersEnabled: Bool = true
    @State private var personalizedContentEnabled: Bool = true
    @State private var emergencyContactName: String = ""
    @State private var emergencyContactNumber: String = ""
    @State private var emergencyContactEmail: String = ""
    
    let languages = [nil, "English", "Spanish", "French"] as [String?]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]), // Matching background
                                       startPoint: .top, endPoint: .bottom)
                            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                
                Text("SETTINGS")
                    .font(.system(size: 34, weight: .medium, design: .default))
                    .padding(.bottom, 20)
                    .foregroundColor(Color("GentleGreen"))
                    .frame(maxWidth: .infinity, alignment: .center)
                
                // Language Picker
                Picker("Select Your Language", selection: $selectedLanguage) {
                    ForEach(languages.dropFirst(), id: \.self) { language in
                        Text("\(language!)").bold().tag(language as String?)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .font(.system(size: 18))
                .foregroundColor(.gray) // Dark gray text
                .accentColor(Color("GentleGreen"))
                
                // Toggles
                VStack(spacing: 10) {
                    Toggle(isOn: $pushNotificationsEnabled) {
                        Text("Push Notifications")
                            .font(.system(size: 18))
                            .foregroundColor(.gray) // Dark gray text
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .accentColor(Color("GentleGreen"))
                    
                    Toggle(isOn: $remindersEnabled) {
                        Text("Reminders")
                            .font(.system(size: 18))
                            .foregroundColor(.gray) // Dark gray text
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .accentColor(Color("GentleGreen"))
                    
                    Toggle(isOn: $personalizedContentEnabled) {
                        Text("Personalized Content")
                            .font(.system(size: 18))
                            .foregroundColor(.gray) // Dark gray text
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .accentColor(Color("GentleGreen"))
                }
                
                // Emergency Contact Form
                Form {
                    Section(header: Text("Emergency Contact").font(.system(size: 18, weight: .medium)).foregroundColor(.gray)) {
                        
                        TextField("Name", text: $emergencyContactName)
                        
                        TextField("Number", text: $emergencyContactNumber)
                        
                        TextField("Email", text: $emergencyContactEmail)
                    }
                }
                
                // Confirm Button
                Button(action: {
                    // Handle confirm action here
                }) {
                    Text("Confirm")
                        .font(.system(size: 18))
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("GentleGreen"))
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}

