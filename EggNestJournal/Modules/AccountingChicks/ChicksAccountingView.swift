import SwiftUI

struct ChicksAccountingView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = ChicksAccountingViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            ZStack {
                background
                navbar
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            if viewModel.chicks.isEmpty {
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
                                        ForEach(viewModel.chicks) { chick in
                                            ChickCellView(chick: chick) {
                                                viewModel.navPath.append(.detail(chick))
                                            }
                                            .contextMenu {
                                                Button {
                                                    viewModel.remove(chick)
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
            }
            .navigationDestination(for: ChicksScreen.self) { screen in
                switch screen {
                    case .add(let chick):
                        AddChickView(chick: chick)
                    case .detail(let chick):
                        ChickDetailView(chick: chick)
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
                        TextStroked(text: "ACCOUNTING\nFOR CHICKS", fontSize: 20)
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
            viewModel.navPath.append(.add(Chick(isMock: false)))
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
    ChicksAccountingView()
}

