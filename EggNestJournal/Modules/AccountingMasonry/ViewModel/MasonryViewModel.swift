import Foundation
import Combine

final class MasonryViewModel: ObservableObject {
    
    private let defaultsService = AppDefaultsManager.shared
    
    @Published var navPath: [MasonryScreen] = []
    
    @Published private(set) var masonries: [Masonry] = []
    
    func load() {
        Task { [weak self] in
            guard let self else { return }
            
            let defaults = await self.defaultsService.fetch([Masonry].self, from: .masonry) ?? []
            
            await MainActor.run {
                self.masonries = defaults
            }
        }
    }
    
    func save(_ masonry: Masonry) {
        Task { [weak self] in
            guard let self else { return }
            
            var defaults = await self.defaultsService.fetch([Masonry].self, from: .masonry) ?? []
            
            if let index = defaults.firstIndex(where: { $0.id == masonry.id }) {
                defaults[index] = masonry
            } else {
                defaults.append(masonry)
            }
            
            let newDefault = defaults
            
            await self.defaultsService.store(newDefault, for: .masonry)
            
            await MainActor.run {
                self.navPath.removeAll()
            }
        }
    }
    
    func remove(_ masonry: Masonry) {
        Task { [weak self] in
            guard let self else { return }
            var defaults = await self.defaultsService.fetch([Masonry].self, from: .masonry) ?? []
            
            if let index = defaults.firstIndex(where: { $0.id == masonry.id }) {
                defaults.remove(at: index)
            }
            
            let newDefault = defaults
            
            await self.defaultsService.store(newDefault, for: .masonry)
            
            await MainActor.run {
                if let index = self.masonries.firstIndex(where: { $0.id == masonry.id }) {
                    self.masonries.remove(at: index)
                }
                
                self.navPath.removeAll()
            }
        }
    }
}
