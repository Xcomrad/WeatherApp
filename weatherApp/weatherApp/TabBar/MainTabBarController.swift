
import UIKit
import SnapKit

final class MainTabBarController: UITabBarController {
    
   private func setupTabBarScreens() {
        
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
        setupAppearance()
    }
    
    private func setupAppearance() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        let style: UIUserInterfaceStyle = isDarkMode ? .dark : .light
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .forEach { windowScene in
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = style
                }
            }
    }
    
    private func styleTabBarItems() {
        guard let items = tabBar.items else { return }
        for item in items {
            item.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15, weight: .medium)], for: .normal)
        }
    }
    
   private func setupStyle() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemIndigo
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.gray.cgColor
        tabBar.layer.cornerRadius = 20
        tabBar.clipsToBounds = true
    }
}

