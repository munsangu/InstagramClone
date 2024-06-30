import SwiftUI
import PhotosUI

struct NewPostView: View {
    @Binding var tabIndex: Int
    @State var viewModel = NewPostViewModel()

    var body: some View {
        VStack {
            HStack {
                Button {
                    tabIndex = 0
                } label: {
                    Image(systemName: "chevron.backward")
                        .tint(.black)
                } //: BUTTON
                
                Spacer()
                
                Text("새 게시물")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
            } //: HSTACK
            .padding(.horizontal)
            
            PhotosPicker(selection: $viewModel.selectedItem) {
                if let image = self.viewModel.postImage {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .clipped()
                } else {
                    Image(systemName: "photo.on.rectangle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }
            } //: PHOTOSPICKER
            .onChange(of: viewModel.selectedItem) { oldValue, newValue in
                Task {
                    await viewModel.convertImage(item: newValue)
                }
            }
            
            TextField("문구를 작성하거나 설문을 추가하세요...", text: $viewModel.caption)
                .padding()
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.uploadPost()
                    viewModel.clearData()
                    tabIndex = 0
                }
            } label: {
                Text("공유")
                    .frame(width: 363, height: 42)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            } //: BUTTON
            .padding()
        } //: VSTACK
    }
}

#Preview {
    NewPostView(tabIndex: .constant(2))
}
