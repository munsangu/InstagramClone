import SwiftUI
import Kingfisher

struct ProfileView: View {
    @State var viewModel = ProfileViewModel()
    @Environment(\.dismiss) var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
        GridItem(.flexible(), spacing: 2),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text(viewModel.username )
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    HStack {
                        if let profileImage = viewModel.profileImage {
                            profileImage
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else if let imageURL = viewModel.user?.profileImageURL{
                            let url = URL(string: imageURL)
                            KFImage(url)
                                .resizable()
                                .frame(width: 75, height: 75)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                                .foregroundStyle(.gray.opacity(0.5))
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                        }
                        
                        VStack {
                            Text("\(viewModel.postCount ?? 0)")
                                .fontWeight(.semibold)
                            
                            Text("게시물")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("\(viewModel.followerCount ?? 0)")
                                .fontWeight(.semibold)
                            
                            Text("팔로워")
                        }
                        .frame(maxWidth: .infinity)
                        
                        VStack {
                            Text("\(viewModel.followingCount ?? 0)")
                                .fontWeight(.semibold)
                            
                            Text("팔로잉")
                        }
                        .frame(maxWidth: .infinity)
                    } //: HSTACK
                    .padding(.horizontal)
                    
                    Text(viewModel.name)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    Text(viewModel.bio)
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    if viewModel.user?.isCurrentUser == true {
                        NavigationLink {
                            ProfileEditingView(viewModel: viewModel)
                        } label: {
                            Text("프로필 편집")
                                .bold()
                                .foregroundStyle(.black)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(.gray.opacity(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        } //: NAVIGATIONLINK
                    } else {
                        let isFollowing = viewModel.user?.isFollowing ?? false
                        Button {
                            if isFollowing {
                                viewModel.unfollow()
                            } else {
                                viewModel.follow()
                            }
                        } label: {
                            Text(isFollowing ? "팔로잉" : "팔로우")
                                .bold()
                                .foregroundStyle(isFollowing ? .black : .white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 35)
                                .background(isFollowing ? .gray.opacity(0.4) : .blue)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal, 10)
                                .padding(.top, 10)
                        }
                    }
                    
                    Divider()
                        .padding()
                    
                    LazyVGrid(columns: columns, spacing: 2) {
                        ForEach(viewModel.posts) { post in
                            let url = URL(string: post.imageURL)
                            KFImage(url)
                                .resizable()
                                .aspectRatio(1, contentMode: .fill)
                        } //: FOREACH
                    } //: LAZYVGRID
                    .task {
                        await viewModel.loadUserPosts()
                    }
                    
                    Spacer()
                } //: VSTACK
            }//: SCROLLVIEW
        } //: NAVIGATIONSTACK
        .task {
            await viewModel.loadUserCountInfo()
        }
        .refreshable {
            await viewModel.loadUserCountInfo()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                        .tint(.black)
                } //: BUTTON
            } //: TOOLBARITEM
        } //: TOOLBAR
    }
}

#Preview {
    ProfileView()
}
