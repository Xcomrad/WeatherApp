
import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {
    
    func setupTabBarScreens() {
        
        let weatherVC = WeatherVC()
        weatherVC.tabBarItem = UITabBarItem(title: "Погода", image: UIImage(systemName: "cloud.sun"), tag: 0)
        
        let settiongVC = SettingsVC()
        settiongVC.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"), tag: 1)
        
        viewControllers = [weatherVC, settiongVC]
        
        styleTabBarItems()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarScreens()
        setupStyle()
    }
    
    func setupStyle() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemIndigo
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.cornerRadius = 20
        tabBar.clipsToBounds = true
    }
    
    private func styleTabBarItems() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
        }
    }
}
    
