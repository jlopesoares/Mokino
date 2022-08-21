//
//  MovieCollectionViewCell.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol MovieCellDelegate: AnyObject {
    
    func updateFavoriteState(for movie: Movie)
    func updateHiddenState(for movie: Movie)
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
            favoritesButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
            favoritesButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
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
    
    @IBOutlet weak var hideMovieButton: UIButton!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    weak var delegate: MovieCellDelegate?
    var movie: Movie?
    
    func setup(movie: Movie) {
        self.movie = movie
        
        titleHeaderLabel.text = "Title:"
        titleLabel.text = movie.title
        
        if let releaseDate = movie.releaseDate {
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
        favoritesButton.isSelected = movie.favorite
        hideMovieButton.isHidden = movie.favorite
    }
    
    @IBAction func favoritesButtonPressed(_ sender: Any) {
        
        guard let movie = movie else {
            return
        }

        delegate?.updateFavoriteState(for: movie)
    }
    
    @IBAction func hideButtonPressed(_ sender: Any) {
        guard let movie = movie else {
            return
        }

        delegate?.updateHiddenState(for: movie)
    }
}
