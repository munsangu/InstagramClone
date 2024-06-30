import SwiftUI

struct BlueButtonView<Content: View>: View {
    let label: Content
    let action: () -> Void
    
    init(action: @escaping () -> Void, @ViewBuilder label: () -> Content) {
        self.label = label()
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            label
                .foregroundStyle(.white)
                .frame(width: 363, height: 42)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}
