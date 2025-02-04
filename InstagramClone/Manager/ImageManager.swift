import SwiftUI
import PhotosUI
import FirebaseStorage

struct ImageSelection {
    let image: Image
    let uiImage: UIImage
}

enum ImagePath {
    case post
    case profile
}

class ImageManager {
    static func convertImage(item: PhotosPickerItem?) async -> ImageSelection? {
        guard let item = item else { return nil }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return nil }
        guard let uiImage = UIImage(data: data) else { return nil }
        let image = Image(uiImage: uiImage)
        let imageSelection = ImageSelection(image: image, uiImage: uiImage)
        return imageSelection
    }
    
    static func uploadImage(uiImage: UIImage, path: ImagePath) async -> String? {
        guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else {
            return nil
        }
        let fileName = UUID().uuidString
        print("fileNale: \(fileName)")
        var imagePath: String = ""
        
        switch path {
        case .post:
            imagePath = "images"
        case .profile:
            imagePath = "profile"
        }
        
        let reference = Storage.storage().reference(withPath: "/\(imagePath)/\(fileName)")
        
        do {
            let metaData = try await reference.putDataAsync(imageData)
            print("medaData: \(metaData)")
            let url = try await reference.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG: Failed to upload image with error \(error.localizedDescription)")
            return nil
        }
    }
}
