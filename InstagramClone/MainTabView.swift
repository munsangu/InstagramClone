import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            FeedView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(1)
            NewPostView(tabIndex: $tabIndex)
                .tabItem {
                    Image(systemName: "plus.square")
                }
                .tag(2)
            VStack {
                Text("Reels")
                Button {
                    AuthManager.shared.signOut()
                } label: {
                    Text("로그 아웃")
                }
            }
                .tabItem {
                    Image(systemName: "movieclapper")
                }
                .tag(3)
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
                .tag(4)
        } //: TABVIEW
        .tint(.black)
    }
}

#Preview {
    MainTabView()
}
