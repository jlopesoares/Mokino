//
//  MainTabBarController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()

        setupViewControllers()
        setupUI()
        
    }
    
    func setupUI() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .customPurple
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = .customBeige
    }
    
    func setupViewControllers() {
        
        let favoritesNavigationController = UINavigationController(rootViewController: UIStoryboard.main.favoritesViewController!)
        favoritesNavigationController.tabBarItem.title = "Favorites"
        favoritesNavigationController.tabBarItem.image = .checkmark
        favoritesNavigationController.navigationItem.largeTitleDisplayMode = .always
        favoritesNavigationController.navigationBar.prefersLargeTitles = true
        favoritesNavigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        favoritesNavigationController.navigationBar.barStyle = .black
        
        
        let searchNavigationController = UINavigationController(rootViewController: UIStoryboard.main.searchViewController!)
        searchNavigationController.tabBarItem.title = "Search"
        searchNavigationController.tabBarItem.image = .strokedCheckmark
        searchNavigationController.navigationItem.largeTitleDisplayMode = .always
        searchNavigationController.navigationBar.prefersLargeTitles = true
        searchNavigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchNavigationController.navigationBar.barStyle = .black
        
        
        
        self.viewControllers = [favoritesNavigationController, searchNavigationController]
    }
}
