import SwiftUI

struct LoginView: View {
    @State var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                GradientBackgroundView()
                
                VStack {
                    Spacer()
                    
                    Image("instagramLogo")
                        .resizable()
                        .frame(width: 57, height: 57)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        TextField("이메일 주소를 입력해주세요.", text: $viewModel.email)
                            .modifier(InstagramTextFieldModifier())
                        
                        SecureField("비밀번호를 입력해주세요.", text: $viewModel.password)
                            .modifier(InstagramTextFieldModifier())
                        
                        BlueButtonView {
                            Task {
                                await viewModel.signIn()
                            }
                        } label: {
                            Text("로그인")
                        }

                        Text("비밀번호를 잊으셨나요?")
                    } //: VSTACK
                    
                    Spacer()
                    
                    NavigationLink {
                        EnterEmailView()
                    } label: {
                        Text("새 계정 만들기")
                            .fontWeight(.bold)
                            .frame(width: 363, height: 42)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.blue, lineWidth: 1)
                            }
                    } //: BUTTON
                } //: VSTACK
            } //: ZSTACK
        } //: NAVIGATIONVIEW
    }
}

#Preview {
    LoginView()
}
