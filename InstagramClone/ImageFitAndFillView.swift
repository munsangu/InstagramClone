import SwiftUI

struct ImageFitAndFillView: View {
    var body: some View {
        VStack {
            Image(systemName: "trash.square.fill")
                .resizable()
            
            Rectangle()
                .frame(width: 200, height: 100)
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .frame(width: 200, height: 100)
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 100)
                .border(.pink, width: 5)      
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 100)
                .border(.pink, width: 5)
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(3, contentMode: .fit)
                .frame(width: 200, height: 100)
                .border(.pink, width: 5)

            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 200, height: 100)
                .border(.blue, width: 5)
                .clipped()  
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 100)
                .border(.blue, width: 5)
                .clipped()
            
            Image(systemName: "trash.square.fill")
                .resizable()
                .aspectRatio(3, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: 200, height: 100)
                .border(.blue, width: 5)
                .clipped()
        } //: VSTACK
    }
}

#Preview {
    ImageFitAndFillView()
}
