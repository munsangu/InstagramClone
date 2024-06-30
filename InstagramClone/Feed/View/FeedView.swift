import SwiftUI

struct FeedView: View {
    @State var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                    VStack {
                        HStack {
                            Image("instagramLogo2")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 110)
                            
                            Spacer()
                            
                            Image(systemName: "heart")
                                .imageScale(.large)
                            
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                        } //: HSTACK
                        .padding(.horizontal)
                        
                        LazyVStack {
                            ForEach(viewModel.posts) { post in
                                FeedCellView(post: post)
                            } //: FOREACH
                        } //: LAZYVSTACK
                        
                        Spacer()
                    } //: VSTACK
            } //: SCROLLVIEW
            .refreshable {
                await viewModel.loadAllPosts()
            }
            .task {
                await viewModel.loadAllPosts()
            }
        } //: NAVIGATIONSTACK
    }
}

#Preview {
    FeedView()
}
