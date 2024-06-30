import SwiftUI

struct CompleteSignUpView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(SignUpViewModel.self) var signUpViewModel
    
    var body: some View {
        @Bindable var signUpViewModel = signUpViewModel
        SignUpBackgroundView {
            VStack {
                Image("instagramLogo2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 172, height: 172)
                    .foregroundStyle(.gray)
                    .opacity(0.5)
                    .overlay {
                        Circle()
                            .stroke(.gray, lineWidth: 2)
                            .opacity(0.5)
                            .frame(width: 185, height: 185)
                    }
                
                Text("\(signUpViewModel.username)님, Instagram에 오신 것을 환영합니다.")
                    .font(.title)
                    .padding(.top, 30)
                    .padding(.horizontal)
                
                Spacer()
                
                BlueButtonView {
                    Task {
                        await signUpViewModel.createUser()
                    }
                } label: {
                    Text("완료")
                } //: BUTTON
                
                Spacer()
            } //: VSTACK
        } //: SIGNUPBACKGROUNDVIEW
    }
}

#Preview {
    CompleteSignUpView()
}
