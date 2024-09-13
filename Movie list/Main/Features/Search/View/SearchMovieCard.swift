import UIKit

class SearchMovieCard: UIView {
    private var searchViewModel: SearchViewModel
    private var movieModel: MovieModel
    public var searchValue: String
    
    private lazy var movieCard: UIStackView = {
        let movieCard = UIStackView()
        movieCard.spacing = 5
        movieCard.distribution = .equalSpacing
        movieCard.axis = .vertical
        movieCard.alignment = .fill
        movieCard.translatesAutoresizingMaskIntoConstraints = false
        
        return movieCard
    }()
    
    init(searchViewModel: SearchViewModel, movieModel: MovieModel, searchValue: String) {
        self.searchViewModel = searchViewModel
        self.movieModel = movieModel
        self.searchValue = searchValue
        super.init(frame: .zero)
        setupView()
        updateMovies()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(movieCard)
        
        NSLayoutConstraint.activate([
            movieCard.topAnchor.constraint(equalTo: topAnchor),
            movieCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieCard.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieCard.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func updateMovies() {
        movieCard.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let movies = searchViewModel.searchMovie(value: searchValue)
        let movieList = movies.isEmpty ? movieModel.moviesByCategory : movies
        
        for (index, movie) in movieList.enumerated() {
            let movieName = UILabel()
            movieName.text = movie.name
            movieName.textAlignment = .center
            movieName.font = Styles.Font.titleFont
            movieName.translatesAutoresizingMaskIntoConstraints = false
            
            let movieRating = UILabel()
            movieRating.text = "Nota: \(String(format:"%.1f", movie.rating ?? ""))"
            movieRating.textAlignment = .center
            movieRating.font = Styles.Font.smallFont
            movieRating.translatesAutoresizingMaskIntoConstraints = false
            
            let movieImage = UIImageView()
            let filePath = Bundle.main.path(forResource: movie.imageUrl, ofType: "jpg")
            let image = filePath != nil ? UIImage(contentsOfFile: filePath!) : UIImage(systemName: "photo")!
            movieImage.clipsToBounds = true
            movieImage.contentMode = .scaleAspectFit
            movieImage.translatesAutoresizingMaskIntoConstraints = false
            movieImage.image = image
            
            NSLayoutConstraint.activate([
                movieImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            ])
            
            movieCard.addArrangedSubview(movieImage)
            movieCard.addArrangedSubview(movieName)
            movieCard.addArrangedSubview(movieRating)
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(movieCardTapped(_:)))
            movieImage.isUserInteractionEnabled = true
            movieImage.addGestureRecognizer(tapGesture)
            movieImage.tag = index
            
            movieImage.alpha = 0
            movieName.alpha = 0
            movieRating.alpha = 0
            UIView.animate(withDuration: 0.5, delay: Double(index) * 0.1, options: .curveEaseInOut, animations: {
                movieImage.alpha = 1
                movieName.alpha = 1
                movieRating.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc private func movieCardTapped(_ sender: UITapGestureRecognizer) {
        guard let index = sender.view?.tag else { return }
        let movies = searchViewModel.searchMovie(value: searchValue)
        let movieList = movies.isEmpty ? movieModel.moviesByCategory : movies
        let selectedMovie = movieList[index]
        
        movieModel.navigateToInfo(movie: selectedMovie)
    }
}
