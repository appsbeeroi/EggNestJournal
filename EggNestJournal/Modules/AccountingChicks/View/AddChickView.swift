import SwiftUI

struct AddChickView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ChicksAccountingViewModel
    
    @State var chick: Chick
    
    @State private var isShowImagePicker = false
    @State private var isShowDatePicker = false
    @State private var dateHasSelected = false
    
    @FocusState var focused: Bool
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                background
                navbar
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: 16) {
                                    imagePicker
                                    nameInput
                                    chicksNumber
                                    dateInput
                                    
                                    if isShowDatePicker {
                                        datePicker
                                    }
                                    
                                    heightInput
                                    saveButton
                                }
                                .padding(.top, 2)
                                .padding(.horizontal, 1)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focused = false
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                }
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
                .animation(.smooth, value: isShowDatePicker)
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $isShowImagePicker) {
                ImagePicker(selectedImage: $chick.image)
            }
            .onChange(of: chick.date) { _ in
                dateHasSelected = true
                isShowDatePicker = false
            }
        }
        .ignoresSafeArea(.keyboard)
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
    
    private var imagePicker: some View {
        Button {
            isShowImagePicker.toggle()
        } label: {
            ZStack {
                if let image = chick.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipped()
                        .cornerRadius(20)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "#472A20"), lineWidth: 1)
                        }
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 120, height: 120)
                        .foregroundStyle(Color(hex: "#DBC0A4"))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(hex: "#472A20"), lineWidth: 1)
                        }
                }
                    
                Image(systemName: "photo")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(Color(hex: "#472A20"))
            }
        }
    }
    
    private var nameInput: some View {
        VStack {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            BaseTextField(text: $chick.name, focused: $focused)
        }
    }
    
    private var chicksNumber: some View {
        VStack {
            Text("Number of chicks")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            BaseTextField(text: $chick.chicksNumber, keyboardType: .numberPad, focused: $focused)
        }
    }
    
    private var dateInput: some View {
        VStack {
            Text("Hatching date")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            Button {
                isShowDatePicker.toggle()
            } label: {
                HStack {
                    let date = chick.date.formatted(.dateTime.year().month(.twoDigits).day())
                    
                    Text(dateHasSelected ? date : "CHOOSE DATE")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.rubik(size: 16))
                        .foregroundStyle(Color(hex: "#472A20").opacity(dateHasSelected ? 1 : 0.5))
                    
                    Image(systemName: isShowDatePicker ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(Color(hex: "#472A20"))
                }
                .frame(height: 55)
                .padding(.horizontal, 16)
                .background(Color(hex: "#E9CDAF"))
                .cornerRadius(20)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color(hex: "#472A20"), lineWidth: 1)
                }
            }
        }
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $chick.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.graphical)
            .padding()
            .background(Color(hex: "#472A20").opacity(0.3))
            .tint(Color(hex: "#472A20"))
            .cornerRadius(20)
    }
    
    private var heightInput: some View {
        VStack {
            Text("Height")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            VStack(spacing: 4) {
                ForEach(ChickHeightType.allCases) { height in
                    Button {
                        chick.height = height
                    } label: {
                        Text(height.rawValue)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .font(.rubik(size: 18))
                            .foregroundStyle(Color(hex: "#472A20"))
                            .background(chick.height == height ? Color(hex: "#98BD78") : Color(hex: "#D6BB9E"))
                            .cornerRadius(20)
                            .overlay {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "#472A20"), lineWidth: 1)
                            }
                    }
                }
            }
        }
    }
    
    private var saveButton: some View {
        Button {
            viewModel.save(chick)
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "SAVE", fontSize: 20)
                }
                .opacity(chick.isSaveable ? 1 : 0.5)
        }
        .disabled(!chick.isSaveable)
    }
}

#Preview {
    AddChickView(chick: Chick(isMock: false))
}

