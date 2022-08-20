//
//  SearchViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController, DetailsNavigationUseCase, MoviesListUseCase {
    
    @IBOutlet weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.delegate = self
            searchTextfield.placeholder = "Search Name"
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            movieslistUIBuilder.cellsRegistration(on: collectionView)
            collectionView.setCollectionViewLayout(movieslistUIBuilder.createCompositionalLayout(), animated: false)
            collectionView.delegate = self
        }
    }
    
    let viewModel: SearchViewModel = SearchViewModel(searchAPI: SearchAPI(provider: SearchService()), favoritesRepository: FavoritesRepository())
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>!
    var movieslistUIBuilder = MoviesListUIBuilder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        view.backgroundColor = .customDarkerGrey
        
        setupCollectionProvider()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextfield.becomeFirstResponder()
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.datasource, toSection: .movies)
        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

//MARK: - Service
extension SearchViewController {
    
    func searchMoviesForCurrentTerm() {
        
        guard let searchTerm = searchTextfield.text else { return }
        
        viewModel.getMovies(for: searchTerm) { result in
            self.updateCollectionView()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetails(with: viewModel.datasource[indexPath.row])
    }
}

//MARK: - Text
extension SearchViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        textField.resignFirstResponder()
        searchMoviesForCurrentTerm()
        return true
    }
}

//MARK: - CollectionView
extension SearchViewController {
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
            movieCell.setup(movie: movie)
            movieCell.delegate = self
            
            return movieCell
        })
    }
}

extension SearchViewController: MovieCellDelegate {
    
    func movieCell(_ movieCell: MovieCollectionViewCell, updateFavoriteState movie: Movie) {

        viewModel.favoritesRepository.updateState(for: movie)
    }
}
