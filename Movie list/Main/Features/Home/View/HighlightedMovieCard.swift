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
        label.text = "\(movie.category! as String) - \( String(format: "%.1f", movie.rating ?? "") as String)"
        label.font = Styles.Font.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        stackView.addSubview(movieLabel)
        stackView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            
            movieLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25),
            movieLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            
            categoryLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10),
            categoryLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
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
