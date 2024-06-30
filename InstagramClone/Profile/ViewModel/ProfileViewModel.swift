import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import FirebaseFirestoreSwift

@Observable
class ProfileViewModel {
    var user: User?
    
    var name: String
    var username: String
    var bio: String
    
    var posts: [Post] = []
    
    var selectedItem: PhotosPickerItem?
    var profileImage: Image?
    var uiImage: UIImage?
    
    var postCount: Int? {
        user?.userCountInfo?.postCount
    }
    var followingCount: Int? {
        user?.userCountInfo?.followingCouint
    }
    var followerCount: Int? {
        user?.userCountInfo?.followerCount
    }
    
    init() {
        let tempUser = AuthManager.shared.currentUser
        self.user = tempUser
        
        self.name = tempUser?.name ?? ""
        self.username = tempUser?.username ?? ""
        self.bio = tempUser?.bio ?? ""
        
        Task {
            await loadUserCountInfo()
        }
    }
    
    init(user: User) {
        self.user = user
        self.name = user.name
        self.username = user.username
        self.bio = user.bio ?? ""
        
        Task {
            await checkFollow()
            await loadUserCountInfo()
        }
    }
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.profileImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func updateUser() async {
        do {
            try await updateUserRemote()
            updateUserLocal()
        } catch {
            print("DEBUG: Failed to update user data with error \(error.localizedDescription)")
        }
    }
    
    func updateUserLocal() {
        if name != "", name != user?.name {
            user?.name = name
        }
        if username.isEmpty == false, username != user?.username {
            user?.username = username
        }
        if !bio.isEmpty, bio != user?.bio {
            user?.bio = bio
        }
    }
    
    func updateUserRemote() async throws {
        var editedData: [String: Any] = [ : ]
        if name != "", name != user?.name {
            editedData["name"] = name
        }
        if username.isEmpty == false, username != user?.username {
            editedData["username"] = username
        }
        if !bio.isEmpty, bio != user?.bio {
            editedData["bio"] = bio
        }
        if let uiImage = self.uiImage {
            guard let imageURL = await ImageManager.uploadImage(uiImage: uiImage, path: .profile) else { return }
            editedData["profileImageURL"] = imageURL
        }
        if !editedData.isEmpty, let userId = user?.id {
            try await Firestore.firestore().collection("Users").document(userId).updateData(editedData)
        }
    }
        
    func loadUserPosts() async {
        guard let userId = user?.id else { return }
        guard let posts = await PostManager.loadUserPosts(userId: userId) else { return }
        self.posts = posts
    }
}

extension ProfileViewModel {
    func follow() {
        Task {
            await AuthManager.shared.follow(userId: user?.id)
            user?.isFollowing = true
            await loadUserCountInfo()
        }
    }
    
    func unfollow() {
        Task {
            await AuthManager.shared.unfollow(userId: user?.id)
            user?.isFollowing = false
            await loadUserCountInfo()
        }
    }    
    
    func checkFollow() async {
        self.user?.isFollowing = await AuthManager.shared.checkFollow(userId: user?.id)
    }
}

extension ProfileViewModel {
    func loadUserCountInfo() async {
        self.user?.userCountInfo = await UserCountManager.loadUserCountInfo(userId: user?.id)
    }
}
