import SwiftUI

struct Chick: Identifiable, Hashable {
    let id: UUID
    var name: String
    var image: UIImage?
    var date: Date
    var height: ChickHeightType?
    var chicksNumber: String
    
    var isSaveable: Bool {
        name != "" && image != nil && height != nil && chicksNumber != ""
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.name = isMock ? "Chick Name" : ""
        self.image = isMock ? UIImage(resource: .Images.Masonry.faliure) : nil
        self.date = Date()
        self.height = isMock ? .adults : nil
        self.chicksNumber = isMock ? "1" : ""
    }
    
    init(from ud: ChickUD, image: UIImage) {
        self.id = ud.id
        self.name = ud.name
        self.image = image
        self.date = ud.date
        self.height = ud.height
        self.chicksNumber = ud.chicksNumber
    }
}
