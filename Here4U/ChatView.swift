import SwiftUI

struct ChatView: View {
    @State private var typedMessage: String = ""
    @State private var messages: [ChatMessage] = []
    
    private var db = DatabaseHelper.sharedInstance  

    
    // Body of the view
    var body: some View {
        VStack {
            // Line barrier
            Divider()
                .background(Color("GentleGreen"))
                .frame(height: 9)
                .padding(.horizontal)
            
            Spacer()
            
            // Chat history
            ScrollView {
                LazyVStack {
                    ForEach(messages) { msg in
                        HStack {
                            if msg.isUser {
                                Spacer()
                                Text(msg.message)
                                    .padding(10)
                                    .background(Color("GentleGreen"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("GentleGreen"))
                                    .padding(.trailing, 10)
                            } else {
                                Image(systemName: "brain")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color("GentleGreen"))
                                    .padding(.leading, 10)
                                Text(msg.message)
                                    .padding(10)
                                    .background(Color.white)
                                    .foregroundColor(.gray)
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            
            // Text input area
            HStack {
                TextField("Type a message", text: $typedMessage)
                    .font(.system(size: 15))
                    .padding(12)
                    .overlay(RoundedRectangle(cornerRadius: 13)
                                .stroke(Color("GentleGreen"), lineWidth: 1))
                
                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("GentleGreen"))
                }
                .padding(.trailing, 10)
            }
            .padding(.bottom, 20)
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .onAppear() {
            loadChatHistory()
        }
    }
    
    // Function to send a message
    private func sendMessage() {
        if !typedMessage.isEmpty {
            let newMessage = ChatMessage(message: typedMessage, isUser: true, timestamp: Date())
            messages.append(newMessage)
            db.saveChatMessage(message: newMessage)  // <-- Save to database
            typedMessage = ""
        }
    }


    
    // Function to load chat history from the database
    private func loadChatHistory() {
        if let chatHistory = db.getChatHistory() {
            print("Loaded chat history: \(chatHistory)")  // <-- Add this line
            self.messages = chatHistory
        }
        
    }
    // Function to load a simulated conversation
        private func loadSimulatedConversation() {
            let userGreeting = ChatMessage(message: "Hi, I'm feeling kind of down today.", isUser: true, timestamp: Date())
            let aiGreeting = ChatMessage(message: "I'm sorry to hear that. Would you like to talk about it?", isUser: false, timestamp: Date())
            
            let userTalk = ChatMessage(message: "Yeah, I've been really stressed about work.", isUser: true, timestamp: Date())
            let aiTalk = ChatMessage(message: "Stress is tough, but I'm here to help. Have you tried any stress relief techniques?", isUser: false, timestamp: Date())
            
            let userSentiment = ChatMessage(message: "Not really, do you have any suggestions?", isUser: true, timestamp: Date())
            let aiRecommendation = ChatMessage(message: "Certainly! Exercise and deep breathing are great ways to relieve stress. Would you like more detailed plans?", isUser: false, timestamp: Date())
            
            // Populate the 'messages' array with simulated conversation
            self.messages = [userGreeting, aiGreeting, userTalk, aiTalk, userSentiment, aiRecommendation]
        }
    }

    // Message model
    struct ChatMessage: Identifiable {
        let id = UUID()
        let message: String
        let isUser: Bool
        let timestamp: Date
    }








