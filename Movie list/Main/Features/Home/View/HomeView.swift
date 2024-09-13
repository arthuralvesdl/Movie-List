import UIKit
import Foundation

class HomeView: UIView, HomeViewDelegate {
    
    private var homeViewModel: HomeViewModel
    private var categoryViewModel: CategoryViewModel
    private var movieModel: MovieModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var upcomingLabel: UILabel = {
        let label = UILabel()
        label.text = "Em breve"
        label.font = Styles.Font.titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Categoria"
        label.font = Styles.Font.subtitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var highlightedMovieCard: HighlightedMovieCard = {
        let highlightedMovieCard = HighlightedMovieCard(movie: movieModel.highlightedMovie!,movieModel: movieModel)
        highlightedMovieCard.translatesAutoresizingMaskIntoConstraints = false
        return highlightedMovieCard
    }()
    
    
    private lazy var upcomingCollectionView: MovieCollectionView = {
        let movies = homeViewModel.getUpcoming()
        return MovieCollectionView(movieModel: movieModel, movies: movies)
    }()
    
    private lazy var newCollectionView: MovieCollectionView = {
        let movies = homeViewModel.getUpcoming()
        return MovieCollectionView(movieModel: movieModel, movies: movies)
    }()
    
    private lazy var moviesByCategoryView: MovieCollectionView = {
        let movies = homeViewModel.getMovies().filter { $0.category == categoryViewModel.categorySelected }
        return MovieCollectionView(movieModel: movieModel, movies: movies)
    }()
    
    private lazy var categoryCollectionView: CategoryCollectionView = {
        let collectionView = CategoryCollectionView(categoryViewModel: categoryViewModel, homeViewModel: homeViewModel)
        return collectionView
    }()
    
    init(movieModel: MovieModel, homeViewModel: HomeViewModel, categoryViewModel: CategoryViewModel) {
        
        self.homeViewModel = homeViewModel
        self.categoryViewModel = categoryViewModel
        self.movieModel = movieModel
        super.init(frame: CGRect())
        
        self.homeViewModel.delegate = self
        self.categoryViewModel.delegate = self
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(upcomingLabel)
        contentView.addSubview(highlightedMovieCard)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Constrains do card do filme destacado
            highlightedMovieCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            highlightedMovieCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            highlightedMovieCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            highlightedMovieCard.heightAnchor.constraint(equalToConstant: 350),
            
            upcomingLabel.topAnchor.constraint(equalTo: highlightedMovieCard.bottomAnchor, constant: 20),
            upcomingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            stackView.topAnchor.constraint(equalTo: upcomingLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
        
        stackView.addArrangedSubview(upcomingCollectionView)
        
        NSLayoutConstraint.activate([
            upcomingCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(upcomingCollectionView.collectionViewHeight))
        ])
        
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(categoryCollectionView)
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 10),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: CGFloat(40))
        ])
        
        stackView.addArrangedSubview(moviesByCategoryView)
        stackView.addArrangedSubview(moviesByCategoryView)
        
        NSLayoutConstraint.activate([
            moviesByCategoryView.heightAnchor.constraint(equalToConstant: CGFloat(moviesByCategoryView.collectionViewHeight))
        ])
    }
    
    func updateMovies(_ movies: [Movie]) {
        moviesByCategoryView.movies = movies
        moviesByCategoryView.reloadData()
    }
}
