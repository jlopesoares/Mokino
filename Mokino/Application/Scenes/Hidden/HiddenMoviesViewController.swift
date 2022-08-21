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
            setupCollectionViewConfigs(delegate: self)
        }
    }
    
    var viewModel = HiddenMoviesViewModel(repository: HiddenMoviesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Screen.HiddenMovies.Title".localized
        
        setupMoviesCellsProvider(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupCollectionSnapshot(with: viewModel.getMovies())
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
        setupCollectionSnapshot(with: viewModel.getMovies())
    }
}

