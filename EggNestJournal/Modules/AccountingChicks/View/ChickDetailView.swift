import SwiftUI

struct ChickDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ChicksAccountingViewModel
    
    let chick: Chick
    
    var body: some View {
        ZStack {
            background
            navbar
            
            VStack {
                VStack(spacing: 50) {
                    VStack(spacing: 16) {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 16) {
                                image
                                name
                                date
                                chicksNumber
                                height
                                editButton
                            }
                            .padding(.top, 2)
                        }
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
        .navigationBarBackButtonHidden()
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
                        TextStroked(text: "ACCOUNTING\nFOR CHICK", fontSize: 20)
                            .offset(y: 10)
                            .multilineTextAlignment(.center)
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
    
    private var image: some View {
        Image(uiImage: chick.image ?? UIImage())
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(hex: "#753802"), lineWidth: 1)
            }
    }
    
    private var name: some View {
        Text(chick.name)
            .font(.rubik(size: 20))
            .foregroundStyle(Color(hex: "#753802"))
    }
    
    private var date: some View {
        Text(chick.date.formatted(.dateTime.year().month(.twoDigits).day()))
            .font(.rubik(size: 16))
            .foregroundStyle(Color(hex: "#753802").opacity(0.5))
    }
    
    private var chicksNumber: some View {
        HStack {
            Text("Number of chicks: \(chick.chicksNumber)")
                .font(.rubik(size: 16))
                .foregroundStyle(Color(hex: "#753802").opacity(0.5))
        }
    }
    
    private var height: some View {
        HStack {
            Text("Nestling growth: \(chick.height?.rawValue ?? "")")
                .font(.rubik(size: 16))
                .foregroundStyle(Color(hex: "#753802").opacity(0.5))
        }
    }
    
    private var editButton: some View {
        Button {
            viewModel.navPath.append(.add(chick))
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "Edit", fontSize: 20)
                }
        }
    }
}

#Preview {
    ChickDetailView(chick: Chick(isMock: true))
}
