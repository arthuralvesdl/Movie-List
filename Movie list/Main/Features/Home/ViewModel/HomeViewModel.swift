struct Movie {
    let id: String
    let name: String
    let imageUrl: String
    let category: String?
    let description: String
    let rating: Double?
}

class HomeViewModel {
    var movieCoordinator: MovieCoordinator?
    var delegate: HomeViewDelegate?
    var movieModel: MovieModel
    
    init(movieCoordinator: MovieCoordinator? = nil, delegate: HomeViewDelegate? = nil, movieModel: MovieModel) {
        self.movieCoordinator = movieCoordinator
        self.delegate = delegate
        self.movieModel = movieModel
    }
    
    func navigateToInfo(movie: Movie){
        movieCoordinator?.navigateToInfo(movie)
    }
    
    func getUpcoming() -> [Movie] {
        return movieModel.upcomingMovies
    }
    
    func getMovies() -> [Movie] {
        return movieModel.moviesByCategory
    }
    
    func updateMovieList(_ categorySelected: String) {
        let moviesFiltered = movieModel.moviesByCategory.filter { $0.category == categorySelected}
        delegate?.updateMovies(moviesFiltered)
    }
}
