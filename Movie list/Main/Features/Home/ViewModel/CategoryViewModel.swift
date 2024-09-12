import Foundation
struct Category {
    let name: String
}
class CategoryViewModel {
    public var categories: [Category] = []
    public var categorySelected: String = ""
    var delegate: HomeViewDelegate?
    
    init() {
        self.categories = [
            Category(name: "Ação"),
            Category(name: "Comédia"),
            Category(name: "Terror"),
            Category(name: "Drama"),
            Category(name: "Ficção científica"),
            Category(name: "Romance")
        ]
        self.categorySelected = self.categories.first!.name
    }
}
