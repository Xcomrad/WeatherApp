
import UIKit

final class SettingsVC: UIViewController {
    
    private let rootView = SettingsView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swithTheme(rootView.segmentControlTheme)
        
    }
    
    func swithTheme(_ sender: UISegmentedControl) {
        rootView.completionSwithTheme = {
            let isDarkMode = sender.selectedSegmentIndex == 1
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
            self.updateAppearance(isDarkMode: isDarkMode)
        }
    }
    
    private func updateAppearance(isDarkMode: Bool) {
        let style: UIUserInterfaceStyle = isDarkMode ? .dark : .light
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .forEach { windowScene in
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = style
                }
            }
    }
}



    
   
