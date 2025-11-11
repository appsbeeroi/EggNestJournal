import UIKit

struct OnboardingModel: Identifiable {
    let id: Int
    let title: String
    let image: ImageResource
    
    init(
        id: Int,
        title: String,
        image: ImageResource
    ) {
        self.id = id
        self.title = title
        self.image = image
    }
    
    static var dataSource: [OnboardingModel] = [
        .init(
            id: 0,
            title: "Welcome to EggNest\nJornal - an application for\nowners of chickens\nand poultry!",
            image: .Images.Onboarding.BG_1
        ),
        .init(
            id: 1,
            title: "Keep records of clutches\nand chicks in a format\nthat is convenient for you!",
            image: .Images.Onboarding.BG_2
        ),
        .init(
            id: 2,
            title: "Write notes and add\nphotos to them!",
            image: .Images.Onboarding.BG_3
        )
    ]
}
