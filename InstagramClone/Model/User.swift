import Foundation
import FirebaseAuth

struct User: Codable, Identifiable {
    let id: String
    let email: String
    var name: String
    var username: String
    var bio: String?
    var profileImageURL: String?
    var isFollowing: Bool?
    
    var userCountInfo: UserCountInfo?
    
    var isCurrentUser: Bool {
        guard let currentUserId = AuthManager.shared.currentUser?.id else { return false }
//        if id == currentUserId {
//            return true
//        } else {
//            return false
//        }
        return id == currentUserId
    }
}

extension User {
    static var DUMMY_USER: User = User(
        id: UUID().uuidString,
        email: "dummy@gmail.com",
        name: "dummy",
        username: "dummy"
    )
}
