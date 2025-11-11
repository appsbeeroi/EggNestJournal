import UIKit

enum MasonryStatus: String, Identifiable, CaseIterable, Codable {
    case inProcess = "In process"
    case hatched = "Hatched"
    case failure = "Failure"
    
    var id: Self {
        self
    }
    
    var icon: ImageResource {
        switch self {
            case .inProcess:
                    .Images.Masonry.inProcess
            case .hatched:
                    .Images.Masonry.hatched
            case .failure:
                    .Images.Masonry.faliure
        }
    }
}
