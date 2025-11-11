import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasOnboardingCompleted") var hasOnboardingCompleted = false
    
    var body: some View {
        if hasOnboardingCompleted {
            MainView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
    ContentView()
}

