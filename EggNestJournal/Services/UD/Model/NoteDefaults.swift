import Foundation

struct NoteUD: Codable {
    let id: UUID
    let name: String
    let text: String

    init(from model: Note) {
        self.id = model.id
        self.name = model.name
        self.text = model.text
    }
}
