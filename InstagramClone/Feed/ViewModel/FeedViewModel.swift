import Foundation
import Firebase

@Observable
class FeedViewModel {
    var posts: [Post] = []
    
    init() {
        Task {
            await loadAllPosts()
        }
    }
    
    func loadAllPosts() async {
        guard let posts = await PostManager.loadAllPosts() else { return }
        self.posts = posts
    }
}
