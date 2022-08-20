//
//  DetailsNavigationUseCase.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol DetailsNavigationUseCase {
    
    func navigateToDetails(with movie: Movie)
}

extension DetailsNavigationUseCase where Self: UIViewController {
    
    func navigateToDetails(with movie: Movie) {
        
           let detailViewModel = DetailsViewModel(movie: movie)
           let detailViewController = UIStoryboard.main.detailsViewController!
           
           detailViewController.viewModel = detailViewModel
           
           navigationController?.pushViewController(detailViewController, animated: true)
    }
}
