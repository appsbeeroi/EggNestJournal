import SwiftUI

struct MasonryCellView: View {
    
    let masonry: Masonry
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                if let status = masonry.status {
                    Image(status.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                
                VStack {
                    Text(masonry.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.rubik(size: 20))
                        .foregroundStyle(Color(hex: "#472A20"))
                    
                    Text(masonry.date.formatted(.dateTime.year().month(.twoDigits).day()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.rubik(size: 14))
                        .foregroundStyle(Color(hex: "#472A20").opacity(0.5))
                }
                
                Image(.Images.pen)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 34, height: 34)
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
            .background(Color(hex: "#E9CDAF"))
            .cornerRadius(20)
        }
    }
}
