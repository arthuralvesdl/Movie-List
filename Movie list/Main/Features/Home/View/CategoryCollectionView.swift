import UIKit

class CategoryCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryCardDelegate {
    
    private var homeViewModel: HomeViewModel
    private var categoryViewModel: CategoryViewModel
    var categories: [Category] = []
    private var selectedIndex: IndexPath?
    
    init(categoryViewModel: CategoryViewModel, homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        self.categoryViewModel = categoryViewModel
        self.categories = categoryViewModel.categories
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4, height: 40)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.delegate = self
        self.dataSource = self
        
        self.register(CategoryCardCell.self, forCellWithReuseIdentifier: "CategoryCardCell")
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsHorizontalScrollIndicator = false
        
        if let initialIndex = categories.firstIndex(where: { $0.name == categoryViewModel.categorySelected }) {
            selectedIndex = IndexPath(row: initialIndex, section: 0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCardCell", for: indexPath) as! CategoryCardCell
        let category = categories[indexPath.row]
        cell.setCategory(categoryName: category.name)
        cell.delegate = self
        
        if selectedIndex == indexPath {
            cell.backgroundColor = UIColor.systemGray3
        } else {
            cell.backgroundColor = .clear
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.curveLinear], animations: {
            cell.alpha = 1
        }, completion: nil)
    }
    
    // Função que define o tamanho dinâmico dos itens
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let category = categories[indexPath.row]
        
        // Estabelece um tamanho mínimo baseado em 1/4 da largura da tela
        let minWidth = UIScreen.main.bounds.width / 4
        let height: CGFloat = 40
        
        // Calcula o tamanho baseado no conteúdo (texto da categoria)
        let categoryName = category.name
        let font = UIFont.systemFont(ofSize: 16) // Fonte usada na célula
        let textWidth = (categoryName as NSString).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil).width + 16 // Padding extra
        
        // Retorna o tamanho ajustado (máximo entre o tamanho mínimo e o tamanho do texto)
        return CGSize(width: max(minWidth, textWidth), height: height)
    }
    
    func didTapCategory(_ cell: CategoryCardCell) {
        guard let indexPath = self.indexPath(for: cell) else { return }
        let categoryName: String = categories[indexPath.row].name
        
        // Atualize a célula selecionada
        let previousSelectedIndex = selectedIndex
        selectedIndex = indexPath
        
        // Recarregar as células afetadas
        if let previousSelectedIndex = previousSelectedIndex {
            self.reloadItems(at: [previousSelectedIndex, indexPath])
        } else {
            self.reloadItems(at: [indexPath])
        }
        
        // Atualize o ViewModel
        self.categoryViewModel.categorySelected = categoryName
        homeViewModel.updateMovieList(categoryName)
    }
}
