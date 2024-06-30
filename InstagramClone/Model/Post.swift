import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let userId: String
    let caption: String
    var like: Int
    let imageURL: String
    let date: Date
    var isLike: Bool?
    
    var user: User?
}

extension Post {
    static var DUMMY_POST: Post = Post(
        id: UUID().uuidString,
        userId: UUID().uuidString,
        caption: "TEST CAPTION",
        like: 125,
        imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclonepractice-6c24a.appspot.com/o/images%2F100192B4-DEA4-4754-BBE1-3A5471F44FB5?alt=media&token=6b56489e-6f24-42aa-903b-0a0a488d1ebc",
        date: Date())
}
