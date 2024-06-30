import SwiftUI

struct EnterUseNameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignUpBackgroundView {
            VStack {
                Text("사용자 이름 만들기")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                Text("사용자 이름을 직접 추가하거나 추천 이름을 사용하세요. 언제든지 변경할 수 있습니다.")
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 10)
                
                TextField("사용자 이름을 입력해주세요.", text: $signUpViewModel.username)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    CompleteSignUpView()
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
    EnterUseNameView()
}
