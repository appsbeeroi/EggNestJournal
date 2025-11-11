import Foundation
import Combine

final class NotesViewModel: ObservableObject {
    
    private let defaultsService = AppDefaultsManager.shared
    private let imageService = ImageVault.instance
    
    @Published var navPath: [NotesScreen] = []
    
    @Published private(set) var notes: [Note] = []
    
    func load() {
        Task { [weak self] in
            guard let self else { return }
            
            let defaults = await self.defaultsService.fetch([NoteUD].self, from: .notes) ?? []
            
            let notes = await withTaskGroup(of: Note?.self) { group in
                for defaultNote in defaults {
                    group.addTask {
                        guard let image = await self.imageService.retrieve(id: defaultNote.id) else { return nil }
                        let note = Note(from: defaultNote, image: image)
                        
                        return note
                    }
                }
                
                var notes: [Note?] = []
                
                for await note in group {
                    notes.append(note)
                }
                
                return notes.compactMap { $0 }
            }
            
            await MainActor.run {
                self.notes = notes
            }
        }
    }
    
    func save(_ note: Note) {
        Task { [weak self] in
            guard let self,
                  let image = note.image else { return }
            
            var defaults = await self.defaultsService.fetch([NoteUD].self, from: .notes) ?? []
            let newDefault = NoteUD(from: note)
            
            await self.imageService.store(image, id: note.id)
            
            if let index = defaults.firstIndex(where: { $0.id == note.id }) {
                defaults[index] = newDefault
            } else {
                defaults.append(newDefault)
            }
            
            await self.defaultsService.store(defaults, for: .notes)
            
            await MainActor.run {
                self.navPath.removeAll()
            }
        }
    }
    
    func remove(_ note: Note) {
        Task { [weak self] in
            guard let self else { return }
            
            var defaults = await self.defaultsService.fetch([NoteUD].self, from: .notes) ?? []
            
            await self.imageService.remove(id: note.id)
            
            if let index = defaults.firstIndex(where: { $0.id == note.id }) {
                defaults.remove(at: index)
            }
            
            await self.defaultsService.store(defaults, for: .notes)
            
            await MainActor.run {
                if let index = self.notes.firstIndex(where: { $0.id == note.id }) {
                    self.notes.remove(at: index)
                }
                
                self.navPath.removeAll()
            }
        }
    }
}
