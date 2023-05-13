import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trackers View Controller
        let trackersVC = TrackersViewController(nibName: nil, bundle: nil)
        trackersVC.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(named: "record"), selectedImage: nil)
        
        
        // Statistics View Controller
        let statisticsVC = StatisticsViewController()
        statisticsVC.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(named: "hare"), selectedImage: nil)
        statisticsVC.navigationItem.title = "Статистика"
        let statisticsNavigationController = UINavigationController()
        statisticsNavigationController.viewControllers = [statisticsVC]
        statisticsNavigationController.navigationBar.backgroundColor = .clear
        
        self.viewControllers = [trackersVC, statisticsNavigationController]
        
    }
}

