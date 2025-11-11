import SwiftUI

struct BaseTextField: View {
    
    @Binding var text: String
    
    let keyboardType: UIKeyboardType
    
    @FocusState.Binding var focused: Bool
    
    init(
        text: Binding<String>,
        keyboardType: UIKeyboardType = .default,
        focused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.keyboardType = keyboardType
        self._focused = focused
    }
    
    var body: some View {
        HStack {
            TextField("", text: $text, prompt: Text("Text...")
                .font(.rubik(size: 16))
                .foregroundColor(Color(hex: "#472A20").opacity(0.5)))
                .font(.rubik(size: 16))
                .foregroundColor(Color(hex: "#472A20"))
                .keyboardType(keyboardType)
                .focused($focused)
            
            if text != "" {
                Button {
                    text = ""
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
        .background(Color(hex: "#E9CDAF"))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(hex: "#472A20"), lineWidth: 1)
        }
    }
}
