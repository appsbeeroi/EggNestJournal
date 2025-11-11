import SwiftUI

struct ChickCellView: View {
    
    let chick: Chick
    let action: () -> Void
    
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 0) {
                    if let image = chick.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 100)
                            .frame(width: (UIScreen.main.bounds.width - 120) / 2)
                            .clipped()
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "#753802"), lineWidth: 1)
                            }
                    }
                    
                    Text(chick.name)
                        .font(.rubik(size: 16))
                        .foregroundStyle(Color(hex: "#472A20"))
                }
                
                Text(chick.date.formatted(.dateTime.year().month(.twoDigits).day()))
                    .font(.rubik(size: 13))
                    .foregroundStyle(Color(hex: "#472A20").opacity(0.5))
            }
            .padding(10)
            .background(Color(hex: "#DBC0A4"))
            .cornerRadius(20)
            
            Button {
                action()
            } label: {
                Image(.Images.button)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 50)
                    .overlay {
                        TextStroked(text: "View", fontSize: 20)
                    }
            }
        }
    }
}
