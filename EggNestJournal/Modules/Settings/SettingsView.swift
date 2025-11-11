import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("SavedNotificationStatus") var savedNotificationStatus = false
    
    @State private var isShowBrowser = false
    @State private var isShowClearAlert = false
    
    @State private var isToggleSwitchedOn = false
    @State private var isShowNotificationAlert = false
    
    var body: some View {
        ZStack {
            background
            navbar
            
            VStack {
                VStack(spacing: 50) {
                    notification
                    aboutTheAppButton
                    clearDataButton
                }
                .padding(.top, 30)
                .padding(.horizontal, 20)
                .padding(.bottom, 270)
                .background(
                    LinearGradient(
                        colors: [
                            Color(hex: "#FFE3C5"),
                            Color(hex: "#C3A88B")
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: [.bottom])
#warning("ссылки")
            if isShowBrowser,
               let url = URL(string: "https://www.apple.com") {
                BrowserView(url: url) {
                    withAnimation {
                        isShowBrowser = false
                    }
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to clear all data?", isPresented: $isShowClearAlert) {
            Button("Yes", role: .destructive) {
                Task {
                    await AppDefaultsManager.shared.delete(.chicks)
                    await AppDefaultsManager.shared.delete(.masonry)
                    await AppDefaultsManager.shared.delete(.notes)
                }
            }
        }
        .alert("The permision denied. Open settings?", isPresented: $isShowNotificationAlert) {
            Button("Yes") {
                UIApplication.shared.openSettings()
            }
            
            Button("No") {
                isToggleSwitchedOn = false
            }
        }
        .onChange(of: isToggleSwitchedOn) { isOn in
            Task {
                switch isOn {
                    case true:
                        switch await PushPermissionService.instance.status {
                            case .granted:
                                savedNotificationStatus = true
                            case .declined:
                                isShowNotificationAlert = true
                            case .notRequested:
                                await PushPermissionService.instance.askForPermission()
                        }
                    case false:
                        savedNotificationStatus = false
                }
            }
        }
    }
    
    private var background: some View {
        Image(.Images.bgLeather)
            .resizeAndCropp()
    }
    
    private var navbar: some View {
        VStack {
            ZStack {
                Image(.Images.baseTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .overlay {
                        TextStroked(text: "Settings", fontSize: 30)
                            .offset(y: 10)
                    }
                
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(.Images.backButton)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.leading, 30)
            }
            .offset(y: -65)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    private var notification: some View {
        HStack {
            Text("Notifications")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            Toggle(isOn: $isToggleSwitchedOn) {}
                .labelsHidden()
                .shadow(color: isToggleSwitchedOn ? .green : .red, radius: 10, x: 0, y: 4)
        }
    }
    
    private var aboutTheAppButton: some View {
        Button {
            withAnimation {
                isShowBrowser.toggle()
            }
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 70)
                .overlay {
                    TextStroked(text: "About the app", fontSize: 20)
                }
        }
    }
    
    private var clearDataButton: some View {
        VStack(spacing: 16) {
            Text("Clear all data")
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            Button {
                isShowClearAlert.toggle()
            } label: {
                Image(.Images.button)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 70)
                    .overlay {
                        TextStroked(text: "Clear", fontSize: 25)
                    }
            }
        }
    }
}

#Preview {
    SettingsView()
}
