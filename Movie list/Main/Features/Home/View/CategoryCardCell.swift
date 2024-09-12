import UIKit

protocol CategoryCardDelegate: AnyObject {
    func didTapCategory(_ cell: CategoryCardCell)
}

class CategoryCardCell: UICollectionViewCell {
    
    weak var delegate: CategoryCardDelegate?
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Font.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
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
        addSubview(categoryLabel)

        layer.cornerRadius = 8.0
        
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
    
   public func setCategory( categoryName: String) {
        categoryLabel.text = categoryName
    }
    
   private func setupTapGesture() {
       let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
       self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        delegate?.didTapCategory(self)
    }
}
