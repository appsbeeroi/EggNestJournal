import SwiftUI

struct MasonryAccounting: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = MasonryViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            ZStack {
                background
                navbar
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            if viewModel.masonries.isEmpty {
                                Text("There is nothing yet...")
                                    .frame(maxHeight: .infinity)
                                    .font(.rubik(size: 24))
                                    .foregroundStyle(Color(hex: "#472A20").opacity(0.5))
                            } else {
                                ScrollView(showsIndicators: false) {
                                    VStack(spacing: 8) {
                                        ForEach(viewModel.masonries) { masonry in
                                            MasonryCellView(masonry: masonry) {
                                                viewModel.navPath.append(.add(masonry))
                                            }
                                            .contextMenu {
                                                Button {
                                                    viewModel.remove(masonry)
                                                } label: {
                                                    Label("Remove", systemImage: "trash")
                                                }
                                            }
                                        }
                                    }
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
                .animation(.smooth, value: viewModel.masonries)
            }
            .navigationDestination(for: MasonryScreen.self) { screen in
                switch screen {
                    case .add(let masonry):
                        AddMasonryView(masonry: masonry, dateHasSelected: masonry.name != "")
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
    
    private var navbar: some View {
        VStack {
            ZStack {
                Image(.Images.baseTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 40)
                    .overlay {
                        TextStroked(text: "ACCOUNTING\nOF MASONRY", fontSize: 20)
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
            viewModel.navPath.append(.add(Masonry(isMock: false)))
        } label: {
            HStack {
                Image(systemName: "questionmark.circle.fill")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.gray.opacity(0.5))
                
                Text("To create")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.rubik(size: 20))
                    .foregroundStyle(Color(hex: "#472A20"))
                
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

#Preview {
    MasonryAccounting()
}

