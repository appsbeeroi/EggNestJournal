import SwiftUI

struct TextStroked: View {
    
    let text: String
    let fontSize: CGFloat
    
    var body: some View {
        ZStack {
            ZStack {
                Text(text)
                    .offset(x: 0, y: 1)
                
                Text(text)
                    .offset(x: 1, y: 1)
                
                Text(text)
                    .offset(x: -1, y: 1)
                
                Text(text)
                    .offset(x: 0, y: 2)
                
                Text(text)
                    .offset(x: -1, y: 2)
                
                Text(text)
                    .offset(x: 1, y: 2)
                
                Text(text)
                    .offset(x: 2, y: 2)
                
                Text(text)
                    .offset(x: -2, y: 2)
                
                Text(text)
                    .offset(x: -1, y: 0)
                
                Text(text)
                    .offset(x: -2, y: 0)
                
                Text(text)
                    .offset(x: 2, y: 0)
                
                Text(text)
                    .offset(x: 1, y: 0)
                
                Text(text)
                    .offset(x: 0, y: -1)
                
                Text(text)
                    .offset(x: -1, y: -1)
                
                Text(text)
                    .offset(x: 1, y: -1)
                
                Text(text)
                    .offset(x: 1, y: -2)
                
                Text(text)
                    .offset(x: 2, y: -2)
                
                Text(text)
                    .offset(x: -2, y: -2)
            }
            .foregroundStyle(Color(hex: "#753802"))
            
            Text(text)
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color.white,
                            Color(hex:"#F3D734")
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        .font(.rubik(size: fontSize))
    }
}

#Preview {
    TextStroked(text: "Hello", fontSize: 40)
}
