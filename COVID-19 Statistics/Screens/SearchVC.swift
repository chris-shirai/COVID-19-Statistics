//
//  SearchVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/1/22.
//

import UIKit

// The SearchVC is the searchable list of countries with their flags
class SearchVC: UIViewController {

    enum Section {
        case main
    }
    
    let mydash = DashboardVC()

    let countryTextField = C19TextField()
    var username: String!

    var countryManager = CountryManager()

    var listOfCountries: [SingleCountryIdentityData] = []
    var filteredListOfCountries: [SingleCountryIdentityData] = []
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, SingleCountryIdentityData>!

    var isSearching = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSearchController()

        view.backgroundColor = .systemBrown

        countryManager.initData()
        listOfCountries = countryManager.getCountryList()


        configureCollectionView()

        updateData(on: listOfCountries)
        configureDataSource()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CountryListCell.self, forCellWithReuseIdentifier: CountryListCell.reuseID)
    }

    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }


    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SingleCountryIdentityData>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryListCell.reuseID, for: indexPath) as! CountryListCell
            cell.set(follower: follower)
            return cell
        })
    }

    func updateData(on countries: [SingleCountryIdentityData]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleCountryIdentityData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(countries)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}


extension SearchVC: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredListOfCountries : listOfCountries
        let country = activeArray[indexPath.item]
        
        let destVC = DashboardVC()
        destVC.setCountryValue(val: country)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredListOfCountries = listOfCountries.filter { $0.display_name.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredListOfCountries)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: listOfCountries)
        isSearching = false
//        self.navigationController?.pushViewController(mydash, animated: true)
    }
}
