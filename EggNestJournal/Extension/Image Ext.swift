import SwiftUI

extension Image {
    func resizeAndCropp() -> some View {
        GeometryReader { geometry in
            self
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .clipped()
        }
        .ignoresSafeArea()
    }
}
