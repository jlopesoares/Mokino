//
//  SearchViewController.swift
//  Mokino
//
//  Created by João Pedro on 19/08/2022.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextfield: UITextField! {
        didSet {
            searchTextfield.delegate = self
            searchTextfield.placeholder = "Search Name"
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "MovieCollectionViewCell")
            collectionView.delegate = self
            collectionView.setCollectionViewLayout(createCompositionalLayout(), animated: false)
        }
    }
    
    let viewModel: SearchViewModel = SearchViewModel(searchAPI: SearchAPI(provider: SearchService()))
    var collectionDataSource: UICollectionViewDiffableDataSource<SearchSections, Movie>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        view.backgroundColor = .customDarkerGrey
        
        
        setupCollectionProvider()
    }
    
    func updateCollectionView() {
        
        var snapshot = NSDiffableDataSourceSnapshot<SearchSections, Movie>()
        snapshot.appendSections([.movies])

        snapshot.appendItems(viewModel.datasource, toSection: .movies)
        
        collectionDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
        let detailViewModel = DetailsViewModel(movie: viewModel.datasource[indexPath.row])
        let detailViewController = UIStoryboard.main.detailsViewController!
        
        detailViewController.viewModel = detailViewModel
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}

//MARK: - Text
extension SearchViewController: UITextFieldDelegate {
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        viewModel.getMovies(for: textField.text!) { result in
            self.updateCollectionView()
        }
        
        return true
    }
    
}

//MARK: - CollectionView
extension SearchViewController {
    
    func setupCollectionProvider() {
        
        collectionDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            
            let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            
            movieCell.setup(movie: movie)
            return movieCell
        })
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(150))
            
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                         leading: 0,
                                                         bottom: 8,
                                                         trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                   heightDimension: .absolute(150))
            
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                         subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsetsReference = .layoutMargins
            section.interGroupSpacing = .zero
          
            return section
        }
    }
}
