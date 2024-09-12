import Foundation
import UIKit

class HomeCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(tabBarItem: UITabBarItem){
        self.navigationController = UINavigationController()
        startHomeViewController(tabBatItem: tabBarItem)
    }
    
    private func startHomeViewController(tabBatItem: UITabBarItem) {
        let movieModel = MovieModel()
        let categoryViewModel = CategoryViewModel()
        let homeViewModel = HomeViewModel(movieModel: movieModel)
        let movieCoordinator = MovieCoordinator(navigationController: navigationController)
        
        movieModel.movieCoordinator = movieCoordinator
        
        let contentView = HomeView(movieModel: movieModel, homeViewModel: homeViewModel,categoryViewModel:categoryViewModel)
        let homeViewController = HomeViewController(contentView: contentView, viewModel: homeViewModel)
        homeViewController.tabBarItem = tabBatItem

        self.navigationController.viewControllers = [homeViewController]
    }
}
