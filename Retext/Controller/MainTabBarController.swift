//
//  MainTabBarController.swift
//  Retext
//
//  Created by Abraham Estrada on 6/1/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        let homeTab = templateNavigationController(title: "Home", unselectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: HomeViewController())
        
        let savedTab = templateNavigationController(title: "Saved", unselectedImage: UIImage(systemName: "square.and.arrow.down")!, selectedImage: UIImage(systemName: "square.and.arrow.down.fill")!, rootViewController: SavedViewController())
        
        viewControllers = [homeTab, savedTab]
        
        tabBar.tintColor = TINTCOLOR
    }
    
    func templateNavigationController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = title
        nav.tabBarItem.selectedImage = selectedImage
        nav.tabBarItem.image = unselectedImage
        nav.navigationBar.tintColor = TINTCOLOR
        
        return nav
    }
}
