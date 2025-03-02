import UIKit
import SwiftUI

class MainTabbarViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
        setUpTabs()
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gray.withAlphaComponent(0.1)
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setUpTabs() {
        let homeVC = createNavigationController(rootViewController: HomeViewController(), title: "Home", imageName: "house")
        let upcomingVC = createNavigationController(rootViewController: UpcomingViewController(), title: "Upcoming", imageName: "play.circle")
        let searchVC = createNavigationController(rootViewController: SearchViewController(), title: "Search", imageName: "magnifyingglass")
        let downloadsVC = createNavigationController(rootViewController: DownloadsViewController(), title: "Downloads", imageName: "arrow.down.to.line")
        
        setViewControllers([homeVC, upcomingVC, searchVC, downloadsVC], animated: false)
    }
    
    private func createNavigationController(rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem = createTabBarItem(title: title, imageName: imageName)
        return navController
    }
    
    private func createTabBarItem(title: String, imageName: String) -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName),
            selectedImage: UIImage(systemName: "\(imageName).fill")
        )
    }
}

struct MainTabbarViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview { MainTabbarViewController() }
            .edgesIgnoringSafeArea(.all)
    }
}
