import Foundation
import Combine

final class ChicksAccountingViewModel: ObservableObject {
    
    private let defaultsService = AppDefaultsManager.shared
    private let imageService = ImageVault.instance
    
    @Published var navPath: [ChicksScreen] = []
    
    @Published private(set) var chicks: [Chick] = []
    
    func load() {
        Task { [weak self] in
            guard let self else { return }
            
            let defaults = await self.defaultsService.fetch([ChickUD].self, from: .chicks) ?? []
            
            let chicks = await withTaskGroup(of: Chick?.self) { group in
                for defaultChick in defaults {
                    group.addTask {
                        guard let image = await self.imageService.retrieve(id: defaultChick.id) else { return nil }
                        let chick = Chick(from: defaultChick, image: image)
                        
                        return chick
                    }
                }
                
                var chicks: [Chick?] = []
                
                for await chick in group {
                    chicks.append(chick)
                }
                
                return chicks.compactMap { $0 }
            }
            
            await MainActor.run {
                self.chicks = chicks
            }
        }
    }
    
    func save(_ chick: Chick) {
        Task { [weak self] in
            guard let self,
                  let image = chick.image else { return }
            
            var defaults = await self.defaultsService.fetch([ChickUD].self, from: .chicks) ?? []
            let newDefault = ChickUD(from: chick)
            
            await self.imageService.store(image, id: chick.id)
            
            if let index = defaults.firstIndex(where: { $0.id == chick.id }) {
                defaults[index] = newDefault
            } else {
                defaults.append(newDefault)
            }
            
            await self.defaultsService.store(defaults, for: .chicks)
            
            await MainActor.run {
                self.navPath.removeAll()
            }
        }
    }
    
    func remove(_ chick: Chick) {
        Task { [weak self] in
            guard let self else { return }
            
            var defaults = await self.defaultsService.fetch([ChickUD].self, from: .chicks) ?? []
            
            await self.imageService.remove(id: chick.id)
            
            if let index = defaults.firstIndex(where: { $0.id == chick.id }) {
                defaults.remove(at: index)
            }
            
            await self.defaultsService.store(defaults, for: .chicks)
            
            await MainActor.run {
                if let index = self.chicks.firstIndex(where: { $0.id == chick.id }) {
                    self.chicks.remove(at: index)
                }
                
                self.navPath.removeAll()
            }
        }
    }
}
