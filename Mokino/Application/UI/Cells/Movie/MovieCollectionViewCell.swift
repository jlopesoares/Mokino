//
//  MovieCollectionViewCell.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    
    func movieCell(_ movieCell: MovieCollectionViewCell, updateFavoriteState movie: Movie)
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
            favoritesButton.tintColor = .customGreen
        }
    }
    
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateHeaderLabel: UILabel! {
        didSet {
            releaseDateHeaderLabel.text = "ReleaseDate:"
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingHeaderLabel: UILabel! {
        didSet {
            ratingHeaderLabel.text = "Average Rating:"
        }
    }
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    weak var delegate: MovieCellDelegate?
    var movie: Movie?
    
    func setup(movie: Movie) {
        self.movie = movie
        
        titleHeaderLabel.text = "Title:"
        titleLabel.text = movie.title
        
        if let releaseDate = movie.releaseDate?.formatted(date: .abbreviated, time: .omitted) {
            releaseDateHeaderLabel.isHidden = false
            releaseDateLabel.isHidden = false
            releaseDateLabel.text = releaseDate
        } else {
            releaseDateHeaderLabel.isHidden = true
            releaseDateLabel.isHidden = true
        }
        
        if let rating = movie.voteAverage,
           !rating.isZero {
            ratingHeaderLabel.isHidden = false
            ratingLabel.isHidden = false
            ratingLabel.text = "\(rating)"
        } else {
            ratingHeaderLabel.isHidden = true
            ratingLabel.isHidden = true
        }
        
        posterImageView.setImage(url: movie.posterURL)
        favoritesButton.isSelected = movie.isFavorite
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        
        guard let movie = movie else {
            return
        }

        delegate?.movieCell(self, updateFavoriteState: movie)
    }
}
