import Foundation

class MovieModel {
    public var upcomingMovies: [Movie] = []
    public var moviesByCategory: [Movie] = []
    public var highlightedMovie: Movie?
    var movieCoordinator: MovieCoordinator?
    
    init(movieCoordinator: MovieCoordinator? = nil) {
        self.movieCoordinator = movieCoordinator
        
        self.upcomingMovies = [
            Movie(id: "1", name: "Filme 1", imageUrl: "", category: "Terror", description: "Uma história aterrorizante sobre uma casa assombrada.", rating: nil),
            Movie(id: "2", name: "Filme 2", imageUrl: "", category: "Comédia", description: "Uma comédia hilária sobre um grupo de amigos em uma viagem de carro.", rating: nil),
            Movie(id: "3", name: "Filme 3", imageUrl: "", category: "Drama", description: "Um drama emocionante que explora as complexidades das relações familiares.", rating: nil),
            Movie(id: "4", name: "Filme 4", imageUrl: "", category: "Drama", description: "Uma jornada emocional através do amor e da perda.", rating: nil),
            Movie(id: "5", name: "Filme 5", imageUrl: "", category: "Ficção científica", description: "Um thriller de ficção científica ambientado em um futuro distópico.", rating: nil),
            Movie(id: "6", name: "Filme 6", imageUrl: "", category: "Romance", description: "Uma história romântica sobre dois estranhos que se encontram por acaso.", rating: nil)
        ]
        
        self.moviesByCategory = [
            Movie(id: "A", name: "Filme A", imageUrl: "", category: "Ação", description: "Uma aventura cheia de ação com emoções sem parar.", rating: 9.0),
            Movie(id: "B", name: "Filme B", imageUrl: "", category: "Comédia", description: "Uma comédia leve sobre um grupo excêntrico de colegas de trabalho.", rating: 7.1),
            Movie(id: "C", name: "Filme C", imageUrl: "", category: "Ação", description: "Um filme de ação de alto risco ambientado no mundo da espionagem internacional.", rating: 8.4),
            Movie(id: "D", name: "Filme D", imageUrl: "", category: "Drama", description: "Um drama envolvente que aborda lutas pessoais e redenção.", rating: 9.5),
            Movie(id: "E", name: "Filme E", imageUrl: "", category: "Ficção científica", description: "Uma épica de ficção científica sobre a sobrevivência da humanidade em um planeta distante.", rating: 8),
            Movie(id: "F", name: "Filme F", imageUrl: "", category: "Romance", description: "Um conto romântico sobre duas almas que se encontram em circunstâncias inesperadas.", rating: 6),
            Movie(id: "G", name: "Filme G", imageUrl: "", category: "Ficção científica", description: "Uma narrativa futurística sobre a exploração de novos mundos.", rating: 7.3),
            Movie(id: "H", name: "Filme H", imageUrl: "", category: "Terror", description: "Uma história de terror cheia de sustos e reviravoltas.", rating: 5.3),
            Movie(id: "I", name: "Filme I", imageUrl: "", category: "Terror", description: "Um conto sombrio de terror psicológico.", rating: 9.4),
            Movie(id: "J", name: "Filme J", imageUrl: "", category: "Drama", description: "Um drama tocante que explora as complexidades emocionais da vida cotidiana.", rating: 4.2),
            Movie(id: "K", name: "Filme K", imageUrl: "", category: "Drama", description: "Uma narrativa profunda sobre esperança e superação.", rating: 8)
        ]
        
        self.highlightedMovie = Movie(id: "Z", name: "Filme Z", imageUrl: "", category: "Aventura", description: "Um filme de aventura épico cheio de emoções.", rating: 9.8)
    }
    
    func navigateToInfo(movie: Movie) {
        movieCoordinator?.navigateToInfo(movie)
    }
}
