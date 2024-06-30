import SwiftUI

struct EnterPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignUpBackgroundView {
            VStack {
                Text("비밀번호 만들기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                SecureField("비밀번호를 입력해주세요.", text: $signUpViewModel.password)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterNameView()
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
    EnterPasswordView()
}
