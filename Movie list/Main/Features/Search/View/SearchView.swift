import Foundation
import UIKit

class SearchView: UIView{
    
    private var movieModel: MovieModel
    private var searchViewModel: SearchViewModel
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
        
        let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchIcon.tintColor = .gray
        searchIcon.contentMode = .scaleAspectFit
        searchTextField.leftView = searchIcon
        searchTextField.leftViewMode = .always

        return searchTextField
    }()
    
    private lazy var searchMovieCard: SearchMovieCard = {
        let movieCard = SearchMovieCard(searchViewModel: self.searchViewModel, movieModel: self.movieModel, searchValue: self.searchTextInput.text ?? "")
        movieCard.translatesAutoresizingMaskIntoConstraints = false

        return movieCard
    }()
    
    init(movieModel: MovieModel, searchViewModel: SearchViewModel) {
        self.movieModel = movieModel
        self.searchViewModel = searchViewModel
        super.init(frame: CGRect())
        setupView()
        addSearchTextFieldTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(contentView)
        contentView.addSubview(searchTextInput)
        contentView.addSubview(scrollView)
        scrollView.addSubview(searchMovieCard)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchTextInput.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            searchTextInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            searchTextInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: searchTextInput.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            searchMovieCard.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            searchMovieCard.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            searchMovieCard.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            searchMovieCard.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            searchMovieCard.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
            
        ])
    }
    
    private func addSearchTextFieldTarget() {
        searchTextInput.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
           searchMovieCard.searchValue = searchTextInput.text ?? ""
           searchMovieCard.updateMovies()
       }
}
