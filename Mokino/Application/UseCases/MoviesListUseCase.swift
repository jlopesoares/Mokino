//
//  MoviesListUseCase.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol MoviesListUseCase {
   
    var collectionView: UICollectionView! { get set }
    var movieslistUIBuilder: MoviesListUIBuilder { get set }
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>! { get set }
}
