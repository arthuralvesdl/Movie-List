import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.navigationBar.barTintColor = UIColor.background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    func start() {
        let tabCoordinator = TabCoordinator(navigationController: navigationController)
        tabCoordinator.start()
    }
}
