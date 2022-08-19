//
//  UIStoryboard+Extensions.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: .main)
    }
    
    var tabBarViewController: MainTabBarController? {
        UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: MainTabBarController.self)) as? MainTabBarController
    }
    
    
    var favoritesViewController: FavoritesViewController? {
        UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: FavoritesViewController.self)) as? FavoritesViewController
    }
    
    var searchViewController: SearchViewController? {
        UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as? SearchViewController
    }
    
    var detailsViewController: DetailsViewController? {
        UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: DetailsViewController.self)) as? DetailsViewController
    }
    
}
