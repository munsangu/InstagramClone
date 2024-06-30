import Foundation

struct Comment: Codable, Identifiable {
    let id: String
    let commentText: String
    
    let postId: String
    let postUserId: String
    
    let commentUserId: String
    var commnetUser: User?
    
    let date: Date
}

extension Comment {
    static var DUMMY_COMMENT: Comment = Comment(
        id: UUID().uuidString,
        commentText: "TEST COMMENT",
        postId: UUID().uuidString,
        postUserId: UUID().uuidString,
        commentUserId: UUID().uuidString,
        date: Date()
    )
}
