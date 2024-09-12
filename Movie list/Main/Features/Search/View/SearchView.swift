import Foundation
import UIKit

class SearchView: UIView{
    
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
    
    public let searchTextInput: UITextField = {
        let searchTextField = UITextField()
        searchTextField.font = Styles.Font.smallFont
        searchTextField.borderStyle = .roundedRect
        searchTextField.autocorrectionType = .no
        searchTextField.keyboardType = .default
        searchTextField.returnKeyType = .done
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.contentVerticalAlignment = .center
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.bounds = CGRect(x: 0, y: 10, width: -5, height: 0)
        
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .gray
        searchIcon.contentMode = .left
        searchIcon.frame = CGRect(x: 0, y: 0, width: 20, height: 20) // Ajuste o tamanho conforme necessário
        searchTextField.bounds = CGRect(x: 0, y: 10, width: -5, height: 0)
        
        searchTextField.leftView = searchIcon
        searchTextField.leftViewMode = .always

        return searchTextField
    }()
    
    private lazy var upcomingCollectionView: MovieCollectionView = {
        let movies = movieModel.upcomingMovies
        return MovieCollectionView(movieModel: movieModel, movies: movies)
    }()
    
    init(movieModel: MovieModel) {
        self.movieModel = movieModel
        super.init(frame: CGRect())
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
        addSubview(contentView)
        contentView.addSubview(searchTextInput)
        contentView.addSubview(scrollView)
   
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchTextInput.topAnchor.constraint(equalTo: topAnchor),
            searchTextInput.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchTextInput.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: searchTextInput.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
