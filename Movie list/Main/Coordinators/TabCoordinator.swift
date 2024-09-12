import UIKit
class TabCoordinator: Coordinator {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
        
        self.tabBarController.tabBar.barTintColor = UIColor.background
        self.tabBarController.tabBar.isMultipleTouchEnabled = false
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
    }
    
    func start() {
        let HomeCoordinator = HomeCoordinator(tabBarItem:UITabBarItem(title: "Início",image: UIImage(systemName: "house"), tag: 0))
        let SearchCoordinator = SearchCoordinator(tabBarItem:UITabBarItem(title: "Pesquisar",image: UIImage(systemName: "magnifyingglass"), tag: 1))
        
        tabBarController.viewControllers = [HomeCoordinator.rootViewController, SearchCoordinator.rootViewController]
        navigationController.viewControllers = [tabBarController]
    }
}
