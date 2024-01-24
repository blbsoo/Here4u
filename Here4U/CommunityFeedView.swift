import SwiftUI

struct CommunityFeedView: View {
    
    struct Comment {
        var id: String
        var content: String
        var seen: Int
    }
    

        
        private func fetchPosts() {
            if let fetchedPosts = DatabaseHelper.sharedInstance.fetchAllPosts() {
                self.posts = fetchedPosts.map { dbPost in
                    // Convert the fetched posts to the Post struct expected by this view
                    // This assumes that your database Post and this Post struct have similar fields
                    return Post(id: dbPost.id, content: dbPost.content, seen: 0, supports: [], comments: [])
                }
            }
        }

    struct Post {
        var id: String
        var content: String
        var seen: Int
        var supports: [String]
        var comments: [Comment]
    }
    @State private var posts: [Post] = [
        Post(id: "User1", content: "This is my first post!", seen: 3, supports: ["User2"], comments: []),
        Post(id: "User2", content: "Loving this app so far!", seen: 5, supports: ["User1", "User3"], comments: []),
        Post(id: "User3", content: "How is everyone?", seen: 2, supports: [], comments: [])
    ]
   
   
    
    @State private var newPostContent: String = ""
    @State private var newCommentContent: String = ""
    @State private var showAddPost: Bool = false
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color("PastelBlue"), Color.white]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        
        HStack {
                                Text("Community Feed")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)  // Fill the entire width
                                    .background(Color("GentleGreen"))  // Background color set to GentleGreen
                            }
                            
                            .padding(.top, -357)
                            Spacer()
       
          
            VStack {
                
                // Full-width header
        
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                       .frame(height: 50)
                
                if showAddPost {
                    HStack {
                        TextField("What's on your mind?", text: $newPostContent)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .overlay(
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        // Action for opening Image/Video Picker
                                    }) {
                                        Image(systemName: "camera")
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.trailing, 8)
                                }
                            )
                        
                        Button("Post", action: addPost)
                            .frame(width: 80) // Adjust width to make it skinnier
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("GentleGreen"))
                            .cornerRadius(8)
                    }
                }
                
                ScrollView {
                    ForEach(posts.indices, id: \.self) { index in
                        VStack {
                            ZStack {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(posts[index].id)
                                            .font(.headline)
                                        Spacer()
                                        Button(action: {
                                            // Delete post
                                            self.posts.remove(at: index)
                                        }) {
                                            Image(systemName: "trash")
                                        }
                                    }
                                    
                                    Text(posts[index].content)
                                    
                                    Spacer()  // This will push the following elements to the bottom
                                    Divider()  // This will draw a line separating the content from the icons
                                    
                                    HStack {
                                        Button(action: {
                                            // Increment seen count
                                            self.posts[index].seen += 1
                                        }) {
                                            Image(systemName: "eye")
                                               
                                        }
                                        
                                        Text("\(posts[index].seen) Seen")
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            // Open comment (Support) dialog
                                        }) {
                                            Image(systemName: "text.bubble")
                                                .foregroundColor(.blue)
                                        }
                                        
                                        Text("\(posts[index].supports.count) Supports")
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                
                                // Display comments here
                                ForEach(posts[index].comments.indices, id: \.self) { commentIndex in
                                    HStack {
                                        Text(posts[index].comments[commentIndex].content)
                                        Spacer()
                                        Button(action: {
                                            // Increment comment seen count
                                            self.posts[index].comments[commentIndex].seen += 1
                                        }) {
                                            Image(systemName: "eye")
                                                
                                        }
                                    }
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                    }
                }
                
                Spacer()
                
                Button("Add New Post", action: toggleAddPost)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("GentleGreen"))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
    }
    
    private func toggleAddPost() {
        self.showAddPost.toggle()
    }
    
    private func addPost() {
        if !self.newPostContent.isEmpty {
            let newPost = Post(id: "Anon", content: newPostContent, seen: 0, supports: [], comments: [])
            self.posts.append(newPost)
            self.newPostContent = ""
            self.showAddPost = false
        }
    }
   
}
