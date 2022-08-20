//
//  FavoritesViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit

class FavoritesViewController: UIViewController, MoviesListUseCase, DetailsNavigationUseCase {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    //MARK: - MoviesListUseCase Dependencies
    var movieslistUIBuilder = MoviesListUIBuilder()
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            movieslistUIBuilder.cellsRegistration(on: collectionView)
            collectionView.setCollectionViewLayout(movieslistUIBuilder.createCompositionalLayout(), animated: false)
            collectionView.delegate = self
        }
    }
    
    var viewModel = FavoritesViewModel(favoriteRepository: FavoritesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(test))
        
        
        title = "Mokino Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .customDarkerGrey
        setupCollectionProvider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCollectionView()
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.getFavoriteMovies(), toSection: .movies)
        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FavoriteCollectionViewCell.self), for: indexPath) as! FavoriteCollectionViewCell
            
            
            movieCell.setup(movie)
            
            return movieCell
        })
    }
    
    @objc func test() {
        
    }
    
}

extension FavoritesViewController: MovieCellDelegate {
    
    func movieCell(_ movieCell: MovieCollectionViewCell, updateFavoriteState movie: Movie) {
        
        viewModel.repository.updateState(for: movie)
        updateCollectionView()
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetails(with: viewModel.getFavoriteMovies()[indexPath.row])
    }
}
