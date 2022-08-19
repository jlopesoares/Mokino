//
//  FavoritesViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    var viewModel: FavoritesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mokino Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.openDetail()
        }
    }
    
    func setupUI() {
        
    }
    
    
    func openDetail() {
        
        let detailVC = UIStoryboard.main.detailsViewController!
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
