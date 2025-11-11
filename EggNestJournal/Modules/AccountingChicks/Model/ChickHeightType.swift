enum ChickHeightType: String, CaseIterable, Identifiable, Codable {
    case toddlers = "Toddlers"
    case teens = "Teens"
    case adults = "Adults"
    
    var id: Self {
        self
    }
}
