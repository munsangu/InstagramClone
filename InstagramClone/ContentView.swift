import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var signUpViewModel = SignUpViewModel()
    
    var body: some View {
        if AuthManager.shared.currentUser != nil {
            MainTabView()
        } else {
            LoginView()
                .environment(signUpViewModel)
        }
    }
}

#Preview {
    ContentView()
}
