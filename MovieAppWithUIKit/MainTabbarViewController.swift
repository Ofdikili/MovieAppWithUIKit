//
//  MainTabbarViewController.swift
//  MovieAppWithUIKit
//
//  Created by Ömer Faruk Dikili on 27.02.2025.
//

import Foundation
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
         let homeVC = createViewController(HomeViewController(), title: "Home", imageName: "house")
         let upcomingVC = createViewController(UpcomingViewController(), title: "Upcoming", imageName: "play.circle")
         let searchVC = createViewController(SearchViewController(), title: "Search", imageName: "magnifyingglass")
         let downloadsVC = createViewController(DownloadsViewController(), title: "Downloads", imageName: "arrow.down.to.line")
         
         setViewControllers([homeVC, upcomingVC, searchVC, downloadsVC], animated: false)
     }

    private func createViewController(_ viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        viewController.tabBarItem = createTabBarItem(title: title, imageName: imageName)
        return viewController
    }
    
    /// TabBarItem oluşturur
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
