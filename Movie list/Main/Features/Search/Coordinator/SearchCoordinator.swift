import Foundation
import UIKit

class SearchCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    
    init(tabBarItem: UITabBarItem){
        self.navigationController = UINavigationController()
        startSearchViewController(tabBatItem: tabBarItem)
    }
    
    private func startSearchViewController(tabBatItem: UITabBarItem) {
        let movieModel = MovieModel()
        let searchViewModel = SearchViewModel(movieModel: movieModel)
        let contentView = SearchView(movieModel: movieModel,searchViewModel: searchViewModel)
        let searchViewController = SearchViewController(contentView: contentView)
        
        let movieCoordinator = MovieCoordinator(navigationController: navigationController)
        movieModel.movieCoordinator = movieCoordinator
        
        searchViewController.tabBarItem = tabBatItem

        self.navigationController.viewControllers = [searchViewController]
    }
}
