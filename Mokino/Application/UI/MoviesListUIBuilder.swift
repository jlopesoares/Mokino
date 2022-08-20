//
//  MoviesListUIBuilder.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

struct MoviesListUIBuilder {
    
    func cellsRegistration(on collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: String(describing: MovieCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: MovieCollectionViewCell.self))
        
        collectionView.register(UINib(nibName: String(describing: FavoriteCollectionViewCell.self), bundle: .main), forCellWithReuseIdentifier: String(describing: FavoriteCollectionViewCell.self))
        
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(150))
            
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                         leading: 0,
                                                         bottom: 8,
                                                         trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(150))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsetsReference = .layoutMargins
            section.interGroupSpacing = .zero
          
            return section
        }
    }
}
