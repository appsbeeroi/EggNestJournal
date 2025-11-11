import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("hasOnboardingCompleted") var hasOnboardingCompleted = false
    
    @State private var source: [OnboardingModel] = OnboardingModel.dataSource
    @State private var currentIndex = 0
    
    var currentData: OnboardingModel {
        source[currentIndex]
    }
    
    var body: some View {
        ZStack {
            image
            
            VStack(spacing: 50) {
                title
                continueButton
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 30)
        }
    }
    
    private var image: some View {
        Image(currentData.image)
            .resizeAndCropp()
            .animation(.smooth, value: currentIndex)
    }
    
    private var title: some View {
        TextStroked(text: currentData.title, fontSize: 28)
            .multilineTextAlignment(.center)
    }
    
    private var continueButton: some View {
        Button {
            nextPage()
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 80)
                .overlay {
                    TextStroked(text: "Continue", fontSize: 22)
                }
        }
    }
    
    private func nextPage() {
        guard currentIndex != source.count - 1 else {
            withAnimation {
                hasOnboardingCompleted = true
            }
            
            return
        }
        
        currentIndex += 1
    }
}

#Preview {
    OnboardingView()
}
