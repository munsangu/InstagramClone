import Foundation

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    
    func signIn() async {
        await AuthManager.shared.signIn(email: email, password: password)
    }
}
