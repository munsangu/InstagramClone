import Foundation

@Observable
class SearchViewModel {
    var users: [User] = []
    
    init() {
        Task {
            await loadAllUserData()
        }
    }
    
    func loadAllUserData() async {
        self.users = await AuthManager.shared.loadAllUserData() ?? []
    }
}
