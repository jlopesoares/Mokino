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
    @IBOutlet weak var hideMovieButton: UIButton!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleHeaderLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
   
    @IBOutlet weak var ratingHeaderLabel: UILabel! {
        didSet {
            ratingHeaderLabel.text = "Movie.AverageRating".localized
        }
    }
    
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
    
    weak var delegate: MovieCellDelegate?
    var movie: Movie?
    
    func setup(movie: Movie) {
        self.movie = movie
        
        titleHeaderLabel.text = "Movie.Title.Hint".localized
        titleLabel.text = movie.title
        sinopseLabel.text = movie.overview
        
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
        favoritesButton.isHidden = movie.hidden
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
