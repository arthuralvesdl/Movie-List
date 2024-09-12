import UIKit

protocol MovieCardDelegate: AnyObject {
    func didTapMovie(_ cell: MovieCollectionCell)
}

class MovieCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MovieCardDelegate {

    private var movieModel: MovieModel
    public var movies: [Movie]
    
    let collectionViewHeight: CGFloat =  UIScreen.main.bounds.width / 2.5
    let collectionViewWidth: CGFloat =  UIScreen.main.bounds.width / 3
    
    init(movieModel: MovieModel, movies: [Movie]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: collectionViewWidth, height: collectionViewHeight)
        
        self.movieModel = movieModel
        self.movies = movies
        
        super.init(frame: .zero, collectionViewLayout: layout)
    
        self.delegate = self
        self.dataSource = self
        
        self.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "CardCell")
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! MovieCollectionCell
        let movie = movies[indexPath.row]
        cell.delegate = self
        
        if let filePath = Bundle.main.path(forResource: movie.imageUrl, ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            cell.configure(with: image)
        } else {
            cell.configure(with:  UIImage(systemName: "photo")! )
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0.1
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.beginFromCurrentState], animations: {
            cell.alpha = 1
        }, completion: nil)
    }
    
    func didTapMovie(_ cell: MovieCollectionCell) {
        guard let indexPath = self.indexPath(for: cell) else { return }
        
        let movie: Movie  = movies[indexPath.row]

        movieModel.navigateToInfo(movie: movie)
    }
}
