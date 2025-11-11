import Foundation

struct Masonry: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var date: Date
    var status: MasonryStatus?
    
    var isSaveable: Bool {
        name != "" && status != nil 
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.name = isMock ? "Mock Name" : ""
        self.date = Date()
        self.status = isMock ? .failure : nil
    }
}
