import SwiftUI
import Kingfisher

struct CommentCellView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            if let imageURL = comment.commnetUser?.profileImageURL {
                KFImage(URL(string: imageURL))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text(comment.commnetUser?.username ?? "")
                    
                    Text(comment.date.relativeTimeString())
                        .foregroundStyle(.gray)
                } //: HSTACK
                
                Text(comment.commentText)
            } //: VSTACK
        } //: HSTACK
    }
}

#Preview {
    CommentCellView(comment: Comment.DUMMY_COMMENT)
}
