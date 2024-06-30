import SwiftUI
import Kingfisher

struct FeedCellView: View {
    @State var viewModel: FeedCellViewModel
    @State var isCommentShowing = false
    
    init(post: Post) {
        self.viewModel = FeedCellViewModel(post: post)
    }
    
    var body: some View {
        VStack {
            KFImage(URL(string: viewModel.post.imageURL))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .top) {
                    HStack {
                        NavigationLink {
                            if let user = viewModel.post.user {
                                ProfileView(viewModel: ProfileViewModel(user: user))
                            }
                        } label: {
                            KFImage(URL(string: viewModel.post.user?.profileImageURL ?? ""))
                                .resizable()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                                .overlay {
                                    Circle()
                                        .stroke(Color(red: 191 / 255, green: 11 / 255, blue: 180 / 255), lineWidth: 2)
                                }
                            
                            Text("\(viewModel.post.user?.username ?? "")")
                                .foregroundStyle(.white)
                                .bold()
                        } //: NAVIGATIONLINK
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.white)
                            .imageScale(.large)
                    } //: HSTACK
                    .padding(5)
                }
            
            HStack {
                let isLike = viewModel.post.isLike ?? false
                Button {
                    Task {
                        isLike
                        ? await viewModel.unlike()
                        : await viewModel.like()
                    }
                } label: {
                    Image(
                        systemName: isLike 
                        ? "heart.fill"
                        : "heart"
                    )
                    .foregroundStyle(
                        isLike
                        ? .red
                        : .primary
                    )
                } //: BUTTON
                
                Button {
                    isCommentShowing = true
                } label: {
                    Image(systemName: "bubble.right")
                } //: BUTTON
                .tint(.black)
                
                Image(systemName: "paperplane")
                
                Spacer()
                
                Image(systemName: "bookmark")
            } //: HSTACK
            .imageScale(.large)
            .padding(.horizontal)
            
            Text("좋아요 \(viewModel.post.like)개")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)        
            
            Text("\(viewModel.post.user?.username ?? "")  \(viewModel.post.caption)")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)     
            
            Button {
                isCommentShowing = true
            } label: {
                Text("댓글 \(viewModel.commentCount)개 더보기")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
            } //: BUTTON
            
            Text("\(viewModel.post.date.relativeTimeString())")
                .foregroundStyle(.gray)
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        } //: VSTACK
        .padding(.bottom)
        .sheet(isPresented: $isCommentShowing) {
            CommentView(post: viewModel.post)
                .presentationDragIndicator(.visible)
        }
        .onChange(of: isCommentShowing) { oldValue, newValue in
            if newValue == false {
                Task {
                    await viewModel.loadCommentCount()
                }
            }
        }
    }
}

#Preview {
    FeedCellView(post: Post(id: "XQIutgvtfkGpYeM7agxf", userId: "T0p247oHSFUq6OSVpSqIAsLWY9i2", caption: "Panda", like: 0, imageURL: "https://firebasestorage.googleapis.com:443/v0/b/instagramclonepractice-6c24a.appspot.com/o/images%2F321440E1-3139-4AE9-8AD5-3E42970ECCE8?alt=media&token=4bbc9247-c7d5-45b4-a46a-dc5c0f58c8ff", date: Date()))
}
