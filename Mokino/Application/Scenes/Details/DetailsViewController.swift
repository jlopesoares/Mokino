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
    
    @IBOutlet weak var releaseDateStackView: UIStackView!
    @IBOutlet weak var releaseDateHeaderLabel: UILabel! {
        didSet {
            releaseDateHeaderLabel.text = "Release Date:"
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    @IBOutlet weak var ratingStackView: UIStackView!
    @IBOutlet weak var ratingHeaderLabel: UILabel! {
        didSet {
            ratingHeaderLabel.text = "Rating:"
        }
    }
    @IBOutlet weak var ratingLabel: UILabel!
    
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        
        titleLabel.text = viewModel.title
        sinopseLabel.text = viewModel.sinopse
        
        headerImageView.setImage(url: viewModel.headerImageURL)
        posterImageView.setImage(url: viewModel.posterImageURL)
        
        ratingLabel.text = viewModel.rating
        releaseDateLabel.text = viewModel.releaseDate
        
    }
}
