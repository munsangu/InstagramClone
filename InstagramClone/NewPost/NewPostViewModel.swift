import SwiftUI
import PhotosUI
import FirebaseStorage
import Firebase
import FirebaseFirestoreSwift

@Observable
class NewPostViewModel {
    var caption: String = ""
    var selectedItem: PhotosPickerItem?
    var postImage: Image?
    var uiImage: UIImage?
    
    func convertImage(item: PhotosPickerItem?) async {
        guard let imageSelection = await ImageManager.convertImage(item: item) else { return }
        self.postImage = imageSelection.image
        self.uiImage = imageSelection.uiImage
    }
    
    func uploadPost() async {
        guard let uiImage else { return }
        guard let imageURL = await ImageManager.uploadImage(uiImage: uiImage, path: .post) else { return }
        guard let userId = AuthManager.shared.currentAuthUser?.uid else { return }
        
        let postReference = Firestore.firestore().collection("posts").document()
        let post = Post(
            id: postReference.documentID, 
            userId: userId,
            caption: caption,
            like: 0,
            imageURL: imageURL,
            date: Date()
        )
        
        do {
            let encodedData = try Firestore.Encoder().encode(post)
            try await postReference.setData(encodedData)
        } catch {
            print("DEBUG: Faield to upload post with error \(error.localizedDescription)")
        }
    }
        
    func clearData() {
        caption = ""
        selectedItem = nil
        postImage = nil
        uiImage = nil
    }
}
