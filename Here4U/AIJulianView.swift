import SwiftUI

struct AIJulianView: View {
    @State private var isActivated: Bool = false
    @State private var pulsate: Bool = false
    @State private var mode: String = "AI"
    @State private var db = DatabaseHelper.sharedInstance

    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        mode = "AI"
                    }) {
                        Image(systemName: "brain")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(mode == "AI" ? Color.white : Color("GentleGreen"))
                    }
                    .frame(width: 55, height: 55)
                    .background(mode == "AI" ? Color("GentleGreen") : Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("GentleGreen"), lineWidth: 2))
                    
                    Button(action: {
                        mode = "Chat"
                    }) {
                        Image(systemName: "message")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundColor(mode == "Chat" ? Color.white : Color("GentleGreen"))
                    }
                    .frame(width: 55, height: 55)
                    .background(mode == "Chat" ? Color("GentleGreen") : Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("GentleGreen"), lineWidth: 2))
                }
                .padding(.top, 16)
                .padding(.trailing, 16)
                
                Spacer()
                
                if mode == "AI" {
                    // Content for AI mode
                } else {
                    // Chat interface
                    ChatView()
                }
            }
            
            
            if isActivated && mode == "AI" {
                Circle()
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("GentleGreen").opacity(0.5))
                    .scaleEffect(pulsate ? 1.3 : 1.0)
                    .animation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: pulsate)
                    .onAppear() {
                        if let (savedIsActivated, savedMode) = db.getAISettings() {
                            self.isActivated = savedIsActivated
                            self.mode = savedMode
                        }
                    }
            }
           

            
            if mode == "AI" {
                Button(action: {
                    self.isActivated.toggle()
                }) {
                    Image(systemName: "mic.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 30)
                        .foregroundColor(Color.white)
                }
                .frame(width: 60, height: 60)
                .background(Color("GentleGreen"))
                .clipShape(Circle())
            }
        }
    }
}

