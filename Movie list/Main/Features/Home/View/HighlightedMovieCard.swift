import UIKit

class HighlightedMovieCard: UIView {
    
    weak var delegate: MovieCardDelegate?
    
    private var movieModel: MovieModel
    private var movie: Movie
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieLabel: UILabel = {
        let label = UILabel()
        label.text = movie.name
        label.font = Styles.Font.bigFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "\(movie.category) - \(String(format: "%.1f", movie.rating ?? ""))"
        label.font = Styles.Font.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Background view for labels with 50% transparency
    private lazy var transparentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.background.withAlphaComponent(0.3) // 50% transparency
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let filePath = Bundle.main.path(forResource: movie.imageUrl, ofType: "jpg")
        let image = filePath != nil ? UIImage(contentsOfFile: filePath!) : UIImage(systemName: "photo")!
        imageView.image = image
        return imageView
    }()
    
    init(movie: Movie, movieModel: MovieModel) {
        self.movie = movie
        self.movieModel = movieModel
        super.init(frame: .zero)
        setupView()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.addArrangedSubview(imageView)
        
        // Add the transparent background behind the labels
        stackView.addSubview(transparentBackgroundView)
        transparentBackgroundView.addSubview(movieLabel)
        transparentBackgroundView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            transparentBackgroundView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            transparentBackgroundView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 50),
            transparentBackgroundView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -50),
            
            transparentBackgroundView.heightAnchor.constraint(equalToConstant: 70),
            
            movieLabel.centerXAnchor.constraint(equalTo: transparentBackgroundView.centerXAnchor),
            
            categoryLabel.bottomAnchor.constraint(equalTo: transparentBackgroundView.bottomAnchor, constant: 0),
            categoryLabel.centerXAnchor.constraint(equalTo: transparentBackgroundView.centerXAnchor, constant: 0)
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(){
        movieModel.navigateToInfo(movie: self.movie)
    }
}
