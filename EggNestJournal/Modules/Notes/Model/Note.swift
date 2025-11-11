import UIKit

struct Note: Identifiable, Hashable {
    let id: UUID
    var name: String
    var image: UIImage?
    var text: String
    
    var isSaveable: Bool {
        text != "" && image != nil && name != ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.text = isMock ? "New note" : ""
        self.image = isMock ? UIImage(resource: .Images.mainBG) : nil
        self.name = isMock ? "Name" : ""
    }
    
    init(from defaults: NoteUD, image: UIImage) {
        self.id = defaults.id
        self.name = defaults.name
        self.image = image
        self.text = defaults.text
    }
}

