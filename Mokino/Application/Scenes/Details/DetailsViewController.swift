//
//  DetailsViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.setDefaultCornerRadius()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var releaseDateHeaderLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupUI()
    }
    
    func setupUI() {
        
        titleLabel.text = viewModel.title
        sinopseLabel.text = viewModel.sinopse
        
        headerImageView.setImage(url: viewModel.headerImageURL)
        posterImageView.setImage(url: viewModel.posterImageURL)
    }
}
