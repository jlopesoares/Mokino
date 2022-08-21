//
//  MoviesListUseCase.swift
//  Mokino
//
//  Created by João Pedro on 20/08/2022.
//

import UIKit

protocol MoviesListUseCase: AnyObject {
   
    var collectionView: UICollectionView! { get set }
    var movieslistUIBuilder: MoviesListUIBuilder { get set }
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>! { get set }
}

extension MoviesListUseCase where Self: UIViewController {
    
    /// Generic function to setup movies collection view configurations
    /// - Parameter delegate: The responsible to handle collection view interactions
    func setupCollectionViewConfigs(delegate: UICollectionViewDelegate) {
        
        movieslistUIBuilder.cellsRegistration(on: collectionView)
        collectionView.setCollectionViewLayout(movieslistUIBuilder.buildCollectionViewLayout(), animated: false)
        collectionView.delegate = delegate
        collectionView.keyboardDismissMode = .onDrag
    }
    
    /// This Generic functions setups the cells provider and the right delegate
    /// - Parameter delegate: The responsible to handle the cell's interations
    func setupMoviesCellsProvider(delegate: MovieCellDelegate) {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
            
            movieCell.setup(movie: movie)
            movieCell.delegate = delegate
            
            return movieCell
        })
    }
    
    func setupCollectionSnapshot(with datasource: [Movie]) {
        
        DispatchQueue.main.async { [weak self] in
            
            var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
            snapshot.appendSections([.movies])
            snapshot.appendItems(datasource, toSection: .movies)
            self?.collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}
