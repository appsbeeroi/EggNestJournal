import Foundation

struct ChickUD: Codable {
    let id: UUID
    let name: String
    let date: Date
    let height: ChickHeightType
    let chicksNumber: String
    
    init(from model: Chick) {
        self.id = model.id
        self.name = model.name
        self.date = model.date
        self.height = model.height ?? .adults
        self.chicksNumber = model.chicksNumber
    }
}
