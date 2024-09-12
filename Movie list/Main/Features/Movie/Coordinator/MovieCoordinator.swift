import UIKit
class MovieCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func navigateToInfo(_ movie: Movie) {
        let viewModel = InfoViewModel(movie: movie)
        let contentView = InfoView(viewModel: viewModel)
        let infoViewController = InfoViewController(contentView: contentView)

        let navController = UINavigationController(rootViewController: infoViewController)
        navController.modalPresentationStyle = .fullScreen
        
        infoViewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissInfoViewController))
        
        self.navigationController.present(navController, animated: true,completion: nil)
    }
    
    @objc private func dismissInfoViewController () {
        self.navigationController.dismiss(animated: true, completion: nil)
    }
}
