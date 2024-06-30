
import SwiftUI

struct EnterNameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignUpBackgroundView {
            VStack {
                Text("이름 입력")
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                                
                TextField("이름를 입력해주세요.", text: $signUpViewModel.name)
                    .modifier(InstagramTextFieldModifier())
                
                NavigationLink {
                    EnterUseNameView()
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
    EnterNameView()
}
