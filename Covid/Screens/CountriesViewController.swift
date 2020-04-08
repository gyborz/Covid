//
//  CountriesViewController.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {
    
    enum Section { case main }
    
    private var countriesStatistics: [Statistics] = []
    private var filteredCountriesStats: [Statistics] = []
    var collectionView: UICollectionView!
    
    private typealias IngredientsDataSource = UICollectionViewDiffableDataSource<Section, Statistics>
    private typealias IngredientsSnapshot = NSDiffableDataSourceSnapshot<Section, Statistics>
    private var dataSource: IngredientsDataSource!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let indicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isTranslucent = true
        configureSearchController()
        configureCollectionView()
        getCountriesStatistics()
        configureDataSource()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search countries"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseID)
    }
    
    private func getCountriesStatistics() {
        showIndicator()
        NetworkManager.shared.getCountriesStatistics { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let countriesStatistics):
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.countriesStatistics = countriesStatistics
                    self.updateData(on: self.countriesStatistics)
                }
            case .failure(let error):
                let alert = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = IngredientsDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, statistics) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseID, for: indexPath) as! CountryCell
            cell.set(country: statistics, for: indexPath)
            return cell
        })
    }
    
    private func updateData(on countriesStats: [Statistics]) {
        var snapshot = IngredientsSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(countriesStats)
//        DispatchQueue.main.async {
//            self.dataSource.apply(snapshot, animatingDifferences: true)
//        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func showIndicator() {
        indicator.frame = view.bounds
        indicator.style = .large
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    
    private func hideIndicator() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }

}

extension CountriesViewController: UICollectionViewDelegate {
    
    
    
}

extension CountriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        //
    }
    
}
