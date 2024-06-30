import SwiftUI
import Kingfisher

struct CommentView: View {
    @State var commentText = ""
    @State var viewModel: CommentViewModel
    
    init(post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            Text("댓글")
                .font(.headline)
                .fontWeight(.semibold)
                .padding(.bottom, 15)
                .padding(.top, 30)
            
            Divider()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.comments) { comment in
                        CommentCellView(comment: comment)
                            .padding(.horizontal)
                            .padding(.top)
                    }
                } //: LAZYVSTACK
            } //: SCROLLVIEW
            
            Divider()
            
            HStack {
                if let imageURL = AuthManager.shared.currentUser?.profileImageURL {
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
                
                TextField("댓글 추가", text: $commentText, axis: .vertical)
                
                Button {
                    Task {
                        await viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                } label: {
                    Text("보내기")
                } //: BUTTON
                .tint(.black)
            } //: HSTACK
            .padding()
        } //: VSTACK
    }
}

#Preview {
    CommentView(post: Post.DUMMY_POST)
}
