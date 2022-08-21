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
            setupCollectionViewConfigs(delegate: self)
        }
    }
    
    var viewModel = FavoritesViewModel(favoriteRepository: FavoritesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Screen.Favorites.Title".localized
        
        setHiddenMoviesButton()
        setupMoviesCellsProvider(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionSnapshot(with: viewModel.getFavoriteMovies())
    }
    
    /// Function to add a Open Hidden Movies action on current Navigation Item
    func setHiddenMoviesButton() {
        
        let hiddenMoviesButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(openHiddenMovies))
        hiddenMoviesButton.tintColor = .customBeige
        navigationItem.rightBarButtonItem = hiddenMoviesButton
    }
}

//MARK: - Movie Cell Delegate
extension FavoritesViewController: MovieCellDelegate {
   
    func updateFavoriteState(for movie: Movie) {
        viewModel.removeFavorite(movie)
        setupCollectionSnapshot(with: viewModel.getFavoriteMovies())
    }
    
    func updateHiddenState(for movie: Movie) {}
}

//MARK: - Navigation
extension FavoritesViewController {
    
    @objc func openHiddenMovies() {
        
        let hiddenMoviesViewController = UIStoryboard.main.hiddenMoviesViewController
        navigationController?.pushViewController(hiddenMoviesViewController!, animated: true)
    }
}

//MARK: - CollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetails(with: viewModel.getFavoriteMovies()[indexPath.row])
    }
}
