import SwiftUI

struct MainView: View {
    
    @State private var isShowSettings = false
    @State private var isShowMasonry = false
    @State private var isShowChicks = false
    @State private var isShowNotes = false
    
    var body: some View {
        ZStack {
            background
            
            VStack(spacing: 60) {
                chickenImage
                masonryButton
                chicksButton
                notesButton
            }
            
            settingsButton
        }
        .fullScreenCover(isPresented: $isShowSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $isShowMasonry) {
            MasonryAccounting()
        }
        .fullScreenCover(isPresented: $isShowChicks) {
            ChicksAccountingView()
        }
        .fullScreenCover(isPresented: $isShowNotes) {
            NotesView()
        }
    }
    
    private var background: some View {
        Image(.Images.mainBG)
            .resizeAndCropp()
    }
    
    private var chickenImage: some View {
        Image(.Images.mainChicken)
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .clipped()
    }
    
    private var settingsButton: some View {
        VStack {
            Button {
                isShowSettings.toggle()
            } label: {
                Image(.Images.settingsButton)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44, height: 44)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top)
        .padding(.leading, 30)
    }
    
    private var masonryButton: some View {
        Button {
            isShowMasonry.toggle()
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "ACCOUNTING\nOF MASONRY", fontSize: 20)
                }
        }
    }
    
    private var chicksButton: some View {
        Button {
            isShowChicks.toggle()
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "ACCOUNTING\nFOR CHICKS", fontSize: 20)
                }
        }
    }
    
    private var notesButton: some View {
        Button {
            isShowNotes.toggle()
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "NOTES", fontSize: 20)
                }
        }
    }
}

#Preview {
    MainView()
}


