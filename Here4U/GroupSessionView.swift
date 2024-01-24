import SwiftUI

struct GroupSessionView: View {
    @State private var showRequestForm = false
    @State private var showUpcomingSessions = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                // Header
                Text("Sessions with Julia")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("GentleGreen"))
                
                Spacer()
                
                // Buttons
                VStack {
                    Button("Request a Session") {
                        self.showRequestForm.toggle()
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button("View Upcoming Sessions") {
                        self.showUpcomingSessions.toggle()
                    }
                    .buttonStyle(CustomButtonStyle())
                    
                    Button("History") {
                        // Button action here
                    }
                    .buttonStyle(CustomButtonStyle())
                }
                
                Spacer()
            }
            
            if showRequestForm {
                GroupSessionRequestForm(showForm: $showRequestForm)
            }
            
            if showUpcomingSessions {
                UpcomingSessionsForm(showForm: $showUpcomingSessions)
            }
        }
    }
}

struct GroupSessionRequestForm: View {
    @Binding var showForm: Bool
    @State private var issue: String = ""
    @State private var groupSize: String = ""
    @State private var additionalInfo: String = ""
    
    var body: some View {
        VStack {
            Text("Request a Session")
                .font(.headline)
                .padding()
            
            Form {
                TextField("What's wrong?", text: $issue)
                TextField("Preferred group size?", text: $groupSize)
                TextField("Additional information", text: $additionalInfo)
            }
            
            Button("Submit") {
                showForm = false
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.bottom, 10)
            
            Button("Cancel") {
                showForm = false
            }
            .padding(.top, 20)
        }
        .frame(width: 300, height: 400)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct UpcomingSessionsForm: View {
    @Binding var showForm: Bool
    
    var body: some View {
        VStack {
            Text("Upcoming Sessions")
                .font(.headline)
                .padding(.bottom, 140)
                .foregroundColor(Color("GentleGreen"))
            
            
            // Empty form as there are no sessions
            
            Button("Close") {
                showForm = false
            }
        }
        .frame(width: 300, height: 400)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .frame(width: 270)
            .background(Color("GentleGreen"))
            .cornerRadius(25)
    }
}

struct GroupSessionView_Previews: PreviewProvider {
    static var previews: some View {
        GroupSessionView()
    }
}
