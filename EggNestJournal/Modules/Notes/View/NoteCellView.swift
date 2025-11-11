import SwiftUI

struct NoteCellView: View {
    
    @State var note: Note
    
    let action: () -> Void
    
    var degrees: Double {
        Double((-7...7).randomElement() ?? 0)
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                if let image = note.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "#753802"), lineWidth: 1)
                        }
                }
                
                Text(note.name)
                    .font(.rubik(size: 20))
                    .foregroundStyle(Color(hex: "#753802"))
            }
            .frame(maxWidth: .infinity)
            .padding(10)
            .background(.white)
            .cornerRadius(20)
            .overlay(alignment: .top) {
                Image(.Images.pin)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .offset(y: -10)
            }
            .rotationEffect(.degrees(degrees))
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 10)
        }
    }
}
