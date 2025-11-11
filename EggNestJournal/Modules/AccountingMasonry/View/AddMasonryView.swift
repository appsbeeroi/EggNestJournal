import SwiftUI

struct AddMasonryView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: MasonryViewModel
    
    @State var masonry: Masonry
    @State var dateHasSelected: Bool
    
    @FocusState var focused: Bool
    
    @State private var isShowPicker = false
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                background
                navbar
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            ScrollView(showsIndicators: false) {
                                VStack(spacing: 8) {
                                    nameInput
                                    dateInput
                                    
                                    if isShowPicker {
                                        datePicker
                                    }
                                    
                                    statusInput
                                }
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
                            
                            saveButton
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.65)
                        .animation(.easeInOut, value: isShowPicker)
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
            .onChange(of: masonry.date) { _ in
                dateHasSelected = true
                isShowPicker = false
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
    
    private var nameInput: some View {
        VStack {
            Text("Name")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            BaseTextField(text: $masonry.name, focused: $focused)
        }
    }
    
    private var dateInput: some View {
        VStack {
            Text("Incubation start date")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            Button {
                isShowPicker.toggle()
            } label: {
                HStack {
                    let date = masonry.date.formatted(.dateTime.year().month(.twoDigits).day())
                    
                    Text(dateHasSelected ? date : "CHOOSE DATE")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.rubik(size: 16))
                        .foregroundStyle(Color(hex: "#472A20").opacity(dateHasSelected ? 1 : 0.5))
                    
                    Image(systemName: isShowPicker ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
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
        DatePicker("", selection: $masonry.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.graphical)
            .padding()
            .background(Color(hex: "#472A20").opacity(0.3))
            .tint(Color(hex: "#472A20"))
            .cornerRadius(20)
    }
    
    private var statusInput: some View {
        VStack {
            Text("Status")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.rubik(size: 20))
                .foregroundStyle(Color(hex: "#472A20"))
            
            VStack(spacing: 4) {
                ForEach(MasonryStatus.allCases) { status in
                    Button {
                        masonry.status = status
                    } label: {
                        Text(status.rawValue)
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .font(.rubik(size: 18))
                            .foregroundStyle(Color(hex: "#472A20"))
                            .background(masonry.status == status ? Color(hex: "#98BD78") : Color(hex: "#D6BB9E"))
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
            viewModel.save(masonry)
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "SAVE", fontSize: 20)
                }
                .opacity(masonry.isSaveable ? 1 : 0.5)
        }
        .disabled(!masonry.isSaveable)
    }
}

#Preview {
    AddMasonryView(masonry: Masonry(isMock: false), dateHasSelected: false)
        .environmentObject(MasonryViewModel())
}
