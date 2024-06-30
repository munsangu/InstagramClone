import SwiftUI

struct EnterEmailView: View {
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignUpBackgroundView {
            VStack {
                Text("이메일 주소 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("회원님에게 연락할 수 있는 이메일 주소를 입력하세요. 이 이메일 주소는 프로필에서 다른 사람에게 공개되지 않습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("이메일 주소를 입력해주세요.", text: $signUpViewModel.email)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterPasswordView()
                } label: {
                    Text("다음")
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                } //: NAVIGATIONLINK
                
                Spacer()
            } //: VSTACK
        } //: SIGNUPBACKGROUNDVIEW
    }
}

#Preview {
    EnterEmailView()
}
