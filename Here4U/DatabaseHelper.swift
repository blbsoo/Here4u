import Foundation
import SQLite

class DatabaseHelper {
    static let sharedInstance = DatabaseHelper()
    private let db: Connection?
    
    // Existing user table
    private let users = Table("users")
    private let id = Expression<Int64>("id")
    private let username = Expression<String>("username")
    private let password = Expression<String>("password")
    private let age = Expression<Int?>("age")
    private let gender = Expression<String?>("gender")
    
    // New table for AI settings
    private let aiSettings = Table("aiSettings")
    private let isActivated = Expression<Bool>("isActivated")
    private let mode = Expression<String>("mode")
    
    // New table for Chat messages
    private let chatMessages = Table("chatMessages")
    private let message = Expression<String>("message")
    private let isUser = Expression<Bool>("isUser")
    private let timestamp = Expression<Date>("timestamp")
    
    // New table for Posts
    private let posts = Table("posts")
    private let postId = Expression<String>("postId")
    private let postContent = Expression<String>("postContent")
    
    // New table for Comments
    private let comments = Table("comments")
    private let commentId = Expression<String>("commentId")
    private let commentContent = Expression<String>("commentContent")
    private let relatedPostId = Expression<String>("relatedPostId")
    
    struct User {
        var id: Int64
        var username: String
        var password: String
        var age: Int?
        var gender: String?
    }
    
    // Initialize the database
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
        ).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
            print("SQLite Database is at \(path)/db.sqlite3")
            createTable()
        } catch {
            db = nil
            print("Unable to open database: \(error)")
        }
    }
    
    // Create all tables
    func createTable() {
        do {
            // Existing user table
            try db?.run(users.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(username, unique: true)
                t.column(password)
                t.column(age)
                t.column(gender)
            })
            
            // New AI settings table
            try db?.run(aiSettings.create(ifNotExists: true) { t in
                t.column(isActivated)
                t.column(mode)
            })
            
            // New Chat messages table
            try db?.run(chatMessages.create(ifNotExists: true) { t in
                t.column(message)
                t.column(isUser)
                t.column(timestamp)
            })
            
            // New Posts table
            try db?.run(posts.create(ifNotExists: true) { t in
                t.column(postId, primaryKey: true)
                t.column(postContent)
            })
            
            // New Comments table
            try db?.run(comments.create(ifNotExists: true) { t in
                t.column(commentId, primaryKey: true)
                t.column(commentContent)
                t.column(relatedPostId)
            })
            
        } catch {
            print("Unable to create table: \(error)")
        }
    }
      
    // Add a new user
    // Add a new user
    func addUser(username: String, password: String, age: Int?, gender: String?) -> Int64? {
        do {
            let insert = users.insert(self.username <- username, self.password <- password, self.age <- age, self.gender <- gender)
            let id = try db?.run(insert)
            return id
        } catch {
            print("Insert failed: \(error)")
            return nil
        }
    }


    // Fetch all users
    func getAllUsers() -> [User]? {
        do {
            var usersArray = [User]()
            for user in try db!.prepare(self.users) {
                usersArray.append(User(
                    id: user[id],
                    username: user[username],
                    password: user[password],
                    age: user[age],  // new field
                    gender: user[gender]  // new field
                ))
            }
            return usersArray
        } catch {
            print("Select failed")
            return nil
        }
    }


    // Update a user
    // Update a user
    func updateUser(id: Int64, newUsername: String, newPassword: String, newAge: Int?, newGender: String?) -> Bool {
        let user = users.filter(self.id == id)
        do {
            let update = user.update([
                self.username <- newUsername,
                self.password <- newPassword,
                self.age <- newAge,  // new field
                self.gender <- newGender  // new field
            ])
            if try db?.run(update) != nil {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        return false
    }


    // Delete a user
    func deleteUser(id: Int64) -> Bool {
        let user = users.filter(self.id == id)
        do {
            if try db?.run(user.delete()) != nil {
                return true
            }
        } catch {
            print("Delete failed")
        }
        return false
    }
    // Method to save AI settings
    func saveAISettings(isActivated: Bool, mode: String) {
        let insert = aiSettings.insert(self.isActivated <- isActivated, self.mode <- mode)
        do {
            try db?.run(insert)
        } catch {
            print("Insert failed: \(error)")
        }
    }

    // Method to get AI settings
    func getAISettings() -> (Bool, String)? {
        do {
            for setting in try db!.prepare(self.aiSettings) {
                return (setting[isActivated], setting[mode])
            }
        } catch {
            print("Select failed")
        }
        return nil
    }

    // Method to save chat message
    func saveChatMessage(message: ChatMessage) {
        do {
            let insert = chatMessages.insert(
                self.message <- message.message,
                self.isUser <- message.isUser,
                self.timestamp <- message.timestamp
            )
            if let rowId = try db?.run(insert) {
                print("Inserted chat message with row id: \(rowId)")
            }
        } catch {
            print("Insert chat message failed: \(error)")
        }
    }
    func addPost(postId: String, postContent: String) {
            let insert = posts.insert(self.postId <- postId, self.postContent <- postContent)
            do {
                try db?.run(insert)
            } catch {
                print("Insert post failed: \(error)")
            }
        }
        
        func addComment(commentId: String, commentContent: String, relatedPostId: String) {
            let insert = comments.insert(self.commentId <- commentId, self.commentContent <- commentContent, self.relatedPostId <- relatedPostId)
            do {
                try db?.run(insert)
            } catch {
                print("Insert comment failed: \(error)")
            }
        }


    

    // Method to get chat history
    func getChatHistory() -> [ChatMessage]? {
        do {
            var chatHistory = [ChatMessage]()
            for chat in try db!.prepare(self.chatMessages) {
                let newMessage = ChatMessage(
                    message: chat[message],
                    isUser: chat[isUser],
                    timestamp: chat[timestamp]
                )
                print("Fetched chat message: \(newMessage)")
                chatHistory.append(newMessage)
            }
            return chatHistory
        } catch {
            print("Select chat messages failed")
            return nil
        }
    }

    // Initialize the database
   



}
// Adding more functionalities to DatabaseHelper
extension DatabaseHelper {
    struct Post {
        var id: String
        var content: String
        var seen: Int
        var supports: [String]
        var comments: [Comment]
    }

    struct Comment {
        var id: String
        var content: String
        var relatedPostId: String
        // Add other fields as needed
    }

    func fetchAllPosts() -> [Post]? {
        var fetchedPosts = [Post]()
        do {
            for post in try db!.prepare(posts) {
                // Assuming you have all these columns in SQLite
                let id = post[postId]
                let content = post[postContent]
                let seen = 0 // Fetch from SQLite if available
                let supports: [String] = [] // Fetch from SQLite if available
                let comments: [Comment] = [] // Fetch associated comments
                
                fetchedPosts.append(Post(id: id, content: content, seen: seen, supports: supports, comments: comments))
            }
            return fetchedPosts
        } catch {
            print("Fetching failed: \(error)")
            return nil
        }
    }
    
    func deletePost(byId id: String) {
        let post = posts.filter(postId == id)
        do {
            try db?.run(post.delete())
        } catch {
            print("Delete failed: \(error)")
        }
    }
   

}




