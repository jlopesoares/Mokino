//
//  FavoriteCollectionViewCell.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sinopseLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func setup(_ movie: Movie) {
        posterImageView.setImage(url: movie.posterURL)
        titleLabel.text = movie.title
        sinopseLabel.text = movie.overview
        ratingLabel.text = "\(movie.voteAverage)"
    }
}
