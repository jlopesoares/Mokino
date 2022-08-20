//
//  MovieCollectionViewCell.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol MovieCollectionViewDelegate: AnyObject {
    
    func movieCell(_ movieCell: MovieCollectionViewCell, updateFavoriteMovie: Movie)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.setDefaultCornerRadius()
        }
    }
    
    @IBOutlet weak var favoritesButton: UIButton! {
        didSet {
            favoritesButton.setImage(UIImage(named: "favorite"), for: .normal)
            favoritesButton.setImage(UIImage(named: "favorite_active"), for: .selected)
        }
    }
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateHeaderLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingHeaderLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    weak var delegate: MovieCollectionViewDelegate?
    var movie: Movie?
    
    func setup(movie: Movie) {
        self.movie = movie
        
        titleHeaderLabel.text = "Title:"
        titleLabel.text = movie.title
        
        releaseDateHeaderLabel.text = "ReleaseDate:"
        releaseDateLabel.text = movie.releaseDate?.formatted(date: .abbreviated, time: .omitted)
        
        ratingHeaderLabel.text = "Average Rating:"
        ratingLabel.text = "\(movie.voteAverage)"
        
        posterImageView.setImage(url: movie.posterURL)
        
        favoritesButton.isSelected = Bool.random()
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        
        guard let movie = movie else {
            return
        }

        delegate?.movieCell(self, updateFavoriteMovie: movie)
    }
}
