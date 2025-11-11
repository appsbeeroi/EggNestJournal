import Foundation

enum StorageKey: String {
    case masonry
    case chicks
    case notes
}

actor AppDefaultsManager {
    
    static let shared = AppDefaultsManager()
    
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func store<T: Codable>(_ value: T, for key: StorageKey) async {
        do {
            let data = try encoder.encode(value)
            defaults.set(data, forKey: key.rawValue)
        } catch let err {
            debugPrint("⚠️ Failed to encode \(T.self): \(err.localizedDescription)")
        }
    }
    
    func fetch<T: Codable>(_ type: T.Type, from key: StorageKey) async -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else {
            return nil
        }
        do {
            return try decoder.decode(type, from: data)
        } catch let err {
            debugPrint("⚠️ Failed to decode \(T.self): \(err.localizedDescription)")
            return nil
        }
    }
    
    func delete(_ key: StorageKey) async {
        defaults.removeObject(forKey: key.rawValue)
    }
}
