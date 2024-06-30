import SwiftUI

struct GradientBackgroundView: View {
    let yellowColor = Color(red: 0.9960784314, green: 0.9764705882, blue: 0.9529411765)
    let redColor = Color(red: 0.9921568627, green: 0.9490196078, blue: 0.9725490196)
    let blueColor = Color(red: 0.9333333, green: 0.968627451, blue: 0.9960784314)
    let greenColor = Color(red: 0.937254902, green: 0.9882352941, blue: 0.9529411765)
    
    var body: some View {
        LinearGradient(
            stops: [
                Gradient.Stop(color: yellowColor, location: 0.1),
                Gradient.Stop(color: redColor, location: 0.3),
                Gradient.Stop(color: blueColor, location: 0.6),
                Gradient.Stop(color: greenColor, location: 1),
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

#Preview {
    GradientBackgroundView()
}
