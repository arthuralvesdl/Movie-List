import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    weak var delegate: MovieCardDelegate?
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
              contentView.addSubview(activityIndicator)
              
              NSLayoutConstraint.activate([
                  activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                  activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
              ])
    }
    
    func configure (with image: UIImage) {
        activityIndicator.stopAnimating()
        imageView.image = image
    }
    func startLoading() {
           imageView.image = nil
           activityIndicator.startAnimating()
       }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        delegate?.didTapMovie(self)
    }
}
