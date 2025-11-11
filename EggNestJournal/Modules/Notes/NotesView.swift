import SwiftUI

struct NotesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = NotesViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            ZStack {
                background
                navbar
                penImage
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            if viewModel.notes.isEmpty {
                                Text("There is nothing yet...")
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .font(.rubik(size: 24))
                                    .foregroundStyle(Color(hex: "#472A20").opacity(0.5))
                            } else {
                                ScrollView(showsIndicators: false) {
                                    LazyVGrid(columns: [
                                        GridItem(spacing: 20),
                                        GridItem(spacing: 20)
                                    ]) {
                                        ForEach(viewModel.notes) { note in
                                            NoteCellView(note: note) {
                                                viewModel.navPath.append(.add(note))
                                            }
                                            .contextMenu {
                                                Button {
                                                    viewModel.remove(note)
                                                } label: {
                                                    Label("Remove", systemImage: "trash")
                                                }
                                            }
                                        }
                                    }
                                    .padding(.top, 10)
                                    .padding(.horizontal, 10)
                                }
                            }
                            
                            addButton
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.65)
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
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
                    .padding(.leading, 20)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(edges: [.bottom])
            }
            .navigationDestination(for: NotesScreen.self) { screen in
                switch screen {
                    case .add(let note):
                        NoteAddView(note: note)
                }
            }
            .onAppear {
                viewModel.load()
            }
        }
        .environmentObject(viewModel)
    }
    
    private var background: some View {
        Image(.Images.bgLeather)
            .resizeAndCropp()
    }
    
    private var penImage: some View {
        Image(.Images.notePen)
            .resizable()
            .scaledToFit()
    }
    
    private var navbar: some View {
        VStack {
            ZStack {
                Image(.Images.baseTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .overlay {
                        TextStroked(text: "Notes", fontSize: 30)
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
    
    private var addButton: some View {
        Button {
            viewModel.navPath.append(.add(Note(isMock: false)))
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "Add", fontSize: 20)
                }
        }
    }
}

#Preview {
    NotesView()
}


