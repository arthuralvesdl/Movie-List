class InfoViewModel {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieInfo() -> Movie {
        return movie
    }
    
    
}
