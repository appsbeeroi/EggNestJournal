import SwiftUI

struct NoteAddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: NotesViewModel
    
    @State var note: Note
    
    @State private var isShowImagePicker = false
    
    @FocusState var focused: Bool
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                background
                navbar
                penImage
                
                VStack {
                    VStack(spacing: 50) {
                        VStack(spacing: 16) {
                            HStack {
                                imagePicker
                                nameInput
                            }
                            
                            ZStack {
                                Text(note.text == "" ? "Enter text..." : note.text)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(Color(hex: "#472A20").opacity(note.text == "" ? 0.5 : 1))
                                    .font(.rubik(size: 13))
                                
                                TextEditor(text: $note.text)
                                    .opacity(0.02)
                                    .focused($focused)
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.5)
                        .padding(20)
                        .background(Color(hex: "#F8EEE3"))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 4)
                        .overlay(alignment: .top) {
                            Image(.Images.pin)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .offset(y: -15)
                        }
                        .rotationEffect(.degrees(-5))
                        
                        saveButton
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
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .padding(.leading, 20)
                    )
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea(edges: [.bottom])
            }
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $isShowImagePicker) {
                ImagePicker(selectedImage: $note.image)
            }
        }
        .ignoresSafeArea(.keyboard)
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
    
    private var saveButton: some View {
        Button {
            viewModel.save(note)
        } label: {
            Image(.Images.button)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 70)
                .overlay {
                    TextStroked(text: "Save", fontSize: 20)
                }
                .opacity(note.isSaveable ? 1 : 0.5)
        }
        .disabled(!note.isSaveable)
    }
    
    private var imagePicker: some View {
        Button {
            isShowImagePicker.toggle()
        } label: {
            ZStack {
                if let image = note.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
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
        HStack {
            TextField("", text: $note.name, prompt: Text("Enter name...")
                .font(.rubik(size: 16))
                .foregroundColor(Color(hex: "#472A20").opacity(0.5)))
                .font(.rubik(size: 16))
                .foregroundColor(Color(hex: "#472A20"))
                .focused($focused)
            
            if note.name != "" {
                Button {
                    note.name = ""
                    focused = false
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.gray.opacity(0.5))
                }
            }
        }
        .frame(height: 55)
        .padding(.horizontal, 16)
        .cornerRadius(20)
    }
}

#Preview {
    NoteAddView(note: Note(isMock: true))
        .environmentObject(NotesViewModel())
}
