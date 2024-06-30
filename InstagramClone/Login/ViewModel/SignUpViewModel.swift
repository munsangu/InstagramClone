import Foundation
import FirebaseAuth

@Observable
class SignUpViewModel {
    var email = ""
    var password = ""
    var name = ""
    var username =  ""
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, name: name, username: username)
        var email = ""
        var password = ""
        var name = ""
        var username =  ""
    }
}
