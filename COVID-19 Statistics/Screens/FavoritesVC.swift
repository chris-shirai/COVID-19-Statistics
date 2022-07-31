//
//  SettingsVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class FavoritesVC: UIViewController {

    let tableView = UITableView()
    var favorites: [SingleCountryIdentityData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()

        getFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
    }


    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }


            switch result {
            case .success(let favorites):

                if favorites.isEmpty {
//                    showEmptyStateView
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
            case .failure(let error):
                // show message - something went wrong
                break
            }

        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
//        let emptyStateView = GFEmptyStateView(message: message)
//        emptyStateView.frame = view.bounds
//        view.addSubview(emptyStateView)
    }




}

// This is simple enough to keep here instead of moving it out
extension FavoritesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    // show dashboard when tapping a row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destVC = DashboardVC()
        destVC.setCountryValue(val: favorite)
        
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
        
//        destVC.selectedCountry = favorite
        
//        navigationController?.pushViewController(destVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let favorite = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {return}
            
            // show error message that we're unable to remove
        }
    }


}
