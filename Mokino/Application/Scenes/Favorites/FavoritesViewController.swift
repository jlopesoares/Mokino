//
//  FavoritesViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mokino Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupUI()
    }
    
    func setupUI() {
        
        
        view.backgroundColor = .customDarkerGrey
        
        
    }
    
    
    func openDetail() {
        
        let detailVC = UIStoryboard.main.detailsViewController!
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
