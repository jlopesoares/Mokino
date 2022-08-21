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
    
    var reachability: Reachability!

    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupNetworkConnectionObserver()
        setupViewControllers()
        setupUI()
    }
}

//MARK: - Reachability
extension MainTabBarController {
    
    func setupNetworkConnectionObserver() {
      
        do {
            reachability = try? Reachability()
            try reachability.startNotifier()
        } catch {
            print("Failed to start network observer")
        }
        
        reachability.whenReachable = { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        reachability.whenUnreachable = { [weak self] _ in
            self?.presentConnectionLostViewController()
        }
    }
}

//MARK: - UI
extension MainTabBarController {
    
    func setupUI() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .customPurple
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = .customBeige
    }
    
    func setupViewControllers() {
        
        if let favoritesVC = UIStoryboard.main.favoritesViewController {
            
            let favoritesNavigationController = UINavigationController(rootViewController: favoritesVC)
            configureNavigationController(favoritesNavigationController,
                                          title: "Favorites",
                                          image: UIImage(systemName: "bookmark") ?? .add)
            
            self.viewControllers = [favoritesNavigationController]
        }
        
        if let searchVC = UIStoryboard.main.searchViewController {
            
            let searchNavigationController = UINavigationController(rootViewController: searchVC)
            configureNavigationController(searchNavigationController,
                                          title: "Search",
                                          image: UIImage(systemName: "magnifyingglass") ?? .actions)
            
            self.viewControllers?.append(searchNavigationController)
        }
    }
    
    func configureNavigationController(_ navigationController: UINavigationController, title: String, image: UIImage) {
        
        navigationController.tabBarItem.image = image
        navigationController.tabBarItem.title = title
        navigationController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.tintColor = .customBeige
    }
}
