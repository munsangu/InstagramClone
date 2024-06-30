import Foundation
import Firebase

class PostManager {
    static func loadAllPosts() async -> [Post]? {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true)
                .getDocuments().documents
            // 방법 1
            //            var posts: [Post] = []
            //            for document in documents {
            //                let post = try document.data(as: Post.self)
            //                posts.append(post)
            //            }
            //            self.posts = posts
            
            // 방법 2
            //            self.posts = try documents.map({ document in
            //                return try document.data(as: Post.self)
            //            })
            
            // 방법 3
            let posts = try documents.compactMap({ document in
                return try document.data(as: Post.self)
            })
            return posts
        } catch {
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
            return nil
        }
    }
    
    static func loadUserPosts(userId: String) async -> [Post]? {
        do {
            let documents = try await Firestore.firestore().collection("posts").order(by: "date", descending: true).whereField("userId", isEqualTo: userId).getDocuments().documents
            var posts: [Post] = []
            for document in documents {
                let post = try document.data(as: Post.self)
                posts.append(post)
            }
            return posts
        } catch {
            print("DEBUG: Failed to load user posts with error \(error.localizedDescription)")
            return nil
        }
    }
}

extension PostManager {
    static func like(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("Users")
        
        async let _ =  usersCollection
            .document(userId)
            .collection("user-like")
            .document(post.id)
            .setData([:])     
        
        async let _ =  postsCollection
            .document(post.id)
            .collection("post-like")
            .document(userId)
            .setData([:])      
        
        async let _ =  postsCollection
            .document(post.id)
            .updateData(["like" : post.like + 1])
    }
    
    static func unlike(post: Post) async {
        guard let userId = AuthManager.shared.currentUser?.id else { return }
        
        let postsCollection = Firestore.firestore().collection("posts")
        let usersCollection = Firestore.firestore().collection("Users")
        
        async let _ =  usersCollection
            .document(userId)
            .collection("user-like")
            .document(post.id)
            .delete()
        
        async let _ =  postsCollection
            .document(post.id)
            .collection("post-like")
            .document(userId)
            .delete()
        
        async let _ =  postsCollection
            .document(post.id)
            .updateData(["like" : post.like - 1])
    }
    
    static func checkLike(post: Post) async -> Bool {
        guard let userId = AuthManager.shared.currentUser?.id else { return false }
        
        do {
            let isLike = try await Firestore.firestore()
                .collection("Users")
                .document(userId)
                .collection("user-like")
                .document(post.id)
                .getDocument()
                .exists
            return isLike
        } catch {
            print("DEBUG: Failed to check like with error \(error.localizedDescription)")
            return false
        }
    }
}
