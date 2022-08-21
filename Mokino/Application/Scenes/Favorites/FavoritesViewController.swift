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
        
        title = "Favorites"
        
        setHiddenMoviesButton()
        setupCollectionProvider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateCollectionView()
    }
    
    func setHiddenMoviesButton() {
        
        let hiddenMoviesButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(openHiddenMovies))
        hiddenMoviesButton.tintColor = .customBeige
        navigationItem.rightBarButtonItem = hiddenMoviesButton
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
    
    @objc func openHiddenMovies() {
        
        let hiddenMoviesViewController = UIStoryboard.main.hiddenMoviesViewController
        navigationController?.pushViewController(hiddenMoviesViewController!, animated: true)
        
    }
}

extension FavoritesViewController: MovieCellDelegate {
   
    func updateFavoriteState(for movie: Movie) {
        
    }
    
    func updateHiddenState(for movie: Movie) {
        
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetails(with: viewModel.getFavoriteMovies()[indexPath.row])
    }
}
