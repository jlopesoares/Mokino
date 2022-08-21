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
            setupCollectionViewConfigs(delegate: self)
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
        
        title = "Screen.Search.Title".localized
        
        setupMoviesCellsProvider(delegate: self)
        searchTextfield.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupCollectionSnapshot(with: viewModel.filteredDatasource)
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

            guard let self = self else { return }
            
            self.setupCollectionSnapshot(with: self.viewModel.filteredDatasource)
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
        setupCollectionSnapshot(with: viewModel.filteredDatasource)
    }
}
