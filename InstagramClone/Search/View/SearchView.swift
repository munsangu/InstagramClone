import SwiftUI
import Kingfisher

struct SearchView: View {
    @State var viewModel = SearchViewModel()
    @State var searchText = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return viewModel.users
        } else {
            return viewModel.users.filter { user in
                user.username.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredUsers) { user in
                NavigationLink {
                    ProfileView(viewModel: ProfileViewModel(user: user))
                } label: {
                    HStack {
                        if let imageURL = user.profileImageURL {
                            KFImage(URL(string: imageURL))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 53, height: 53)
                                .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 53, height: 53)
                                .opacity(0.5)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(user.username)
                        } //: VSTACK
                    } //: HSTACK
                } //: NAVIGATIONLINK
                .listRowSeparator(.hidden)
            } //: LIST
            .listStyle(.plain)
        .searchable(text: $searchText, prompt: "검색")
        } //: NAVIGATIONSTACK
    }
}

#Preview {
    SearchView()
}
