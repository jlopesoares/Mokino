//
//  SearchViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController, DetailsNavigationUseCase, MoviesListUseCase {
    
    //MARK: - Outlets
    @IBOutlet weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.delegate = self
            searchTextfield.placeholder = "Search.Placeholder".localized
            searchTextfield.returnKeyType = .search
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            movieslistUIBuilder.cellsRegistration(on: collectionView)
            collectionView.setCollectionViewLayout(movieslistUIBuilder.createCompositionalLayout(), animated: false)
            collectionView.delegate = self
            collectionView.keyboardDismissMode = .onDrag
        }
    }
    
    //MARK: - Movies List Dependencies
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>!
    var movieslistUIBuilder = MoviesListUIBuilder()
    
    let viewModel: SearchViewModel = SearchViewModel(searchAPI: SearchAPI(provider: SearchService(),
                                                                          favoritesRepository: FavoritesRepository(),
                                                                          hiddenMoviesRepository: HiddenMoviesRepository()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        
        setupCollectionProvider()
        searchTextfield.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupInitialCollectionSnapshot()
    }
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
          
            movieCell.setup(movie: movie)
            movieCell.delegate = self
            
            return movieCell
        })
    }
    
    func setupInitialCollectionSnapshot() {
        
        DispatchQueue.main.async {
            
            var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
            snapshot.appendSections([.movies])
            snapshot.appendItems(self.viewModel.filteredDatasource, toSection: .movies)
            self.collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
    
    func updateCollectionView() {
        
        DispatchQueue.main.async {
            
            var snapshot = self.collectionDataSource.snapshot()
            snapshot.reloadItems(self.viewModel.filteredDatasource)
            self.collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}

//MARK: - Service
extension SearchViewController {
    
    func searchMoviesForCurrentTerm() {
        
        guard let searchTerm = searchTextfield.text else { return }
        
        viewModel.getMovies(for: searchTerm) { [weak self] result in
            self?.setupInitialCollectionSnapshot()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigateToDetails(with: viewModel.filteredDatasource[indexPath.row])
    }
}

//MARK: - TextField
extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textField.resignFirstResponder()
        searchMoviesForCurrentTerm()
        return true
    }
}

extension SearchViewController: MovieCellDelegate {
    
    func updateFavoriteState(for movie: Movie) {
        
        viewModel.updateFavoriteState(for: movie)
        updateCollectionView()
    }
    
    func updateHiddenState(for movie: Movie) {
        
        viewModel.updateHideState(for: movie)
        setupInitialCollectionSnapshot()
    }
}
