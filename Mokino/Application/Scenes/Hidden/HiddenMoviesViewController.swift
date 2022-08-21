//
//  HiddenMoviesViewController.swift
//  Mokino
//
//  Created by João Pedro on 21/08/2022.
//

import UIKit

class HiddenMoviesViewController: UIViewController, MoviesListUseCase, DetailsNavigationUseCase {

    //MARK: - MoviesListUseCase Dependencies
    var movieslistUIBuilder = MoviesListUIBuilder()
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            movieslistUIBuilder.cellsRegistration(on: collectionView)
            collectionView.setCollectionViewLayout(movieslistUIBuilder.createCompositionalLayout(), animated: false)
            collectionView.delegate = self
            collectionView.keyboardDismissMode = .onDrag
        }
    }
    
    var viewModel = HiddenMoviesViewModel(repository: HiddenMoviesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Hidden Movies"
        
        view.backgroundColor = .customDarkerGrey
        setupCollectionProvider()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCollectionView()
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
        snapshot.appendSections([.movies])
        snapshot.appendItems(viewModel.getMovies(), toSection: .movies)
        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCollectionViewCell.self), for: indexPath) as! MovieCollectionViewCell
            movieCell.setup(movie: movie)
            movieCell.delegate = self
            
            return movieCell
        })
    }
}

extension HiddenMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetails(with: viewModel.getMovies()[indexPath.row])
    }
}

extension HiddenMoviesViewController: MovieCellDelegate {
    
    func updateFavoriteState(for movie: Movie) {}

    func updateHiddenState(for movie: Movie) {
        viewModel.removeHidden(movie)
        updateCollectionView()
    }
}

