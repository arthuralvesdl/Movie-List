import UIKit

class SearchViewModel {
    
    public var movieModel: MovieModel
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
    }
    
    func searchMovie(value: String) -> [Movie]{
        let movies = movieModel.moviesByCategory.filter { $0.name.contains(value) || $0.category.contains(value)}
        return movies   
    }
}
