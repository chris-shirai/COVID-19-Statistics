//
//  SearchVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/1/22.
//

import UIKit

class SearchVC: UIViewController {
    
    enum Section {
        case main
    }
    
    let countryTextField = C19TextField()
    var username: String!

    var countryManager = CountryManager()

    var listOfCountries: [SingleCountryIdentityData] = []
    var collectionView: UICollectionView!

    var dataSource: UICollectionViewDiffableDataSource<Section, SingleCountryIdentityData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        
        countryManager.initData()
        listOfCountries = countryManager.getCountryList()
        
        
        configureCollectionView()

  updateData()
        configureDataSource()
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CountryListCell.self, forCellWithReuseIdentifier: CountryListCell.reuseID)
    }


//    func getFollowers() {
//
//
//        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
//            guard let self = self else {return}
//
//            switch result {
//            case .success(let followers):
//                self.followers = followers
//                self.updateData()
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
//            }
//
//        }
//
//    }
//
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, SingleCountryIdentityData>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryListCell.reuseID, for: indexPath) as! CountryListCell
            cell.set(follower: follower)
            return cell
        })
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SingleCountryIdentityData>()
        snapshot.appendSections([.main])
        snapshot.appendItems(listOfCountries)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    

}
