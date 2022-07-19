//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {

    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews: [UIView] = []
    var selectedCountry: SingleCountryIdentityData!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewController()

        layoutUI()
        getCountryCovidData()

    }

    func getCountryCovidData() {
        NetworkManager.shared.getCountryCovidData(for: selectedCountry.api_name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let countryCovidData):
                DispatchQueue.main.async {
                    self.add(childVC: C19CountryInfoHeaderVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.headerView)
                    
                    self.add(childVC: GFRepoItemVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.itemViewOne)
                    
                    
                    
                    var itemInfoViewOne = C19ItemInfoView()
                    var itemInfoViewTwo = C19ItemInfoView()
                    
                    
                    var stackView = UIStackView()
                    stackView.translatesAutoresizingMaskIntoConstraints=false

//                    self.view.addSubview(stackView)
                    let padding: CGFloat = 20
                    self.itemViewTwo.addSubview(stackView)
                    NSLayoutConstraint.activate([
                        stackView.topAnchor.constraint(equalTo: self.itemViewTwo.topAnchor, constant: padding),
                        stackView.leadingAnchor.constraint(equalTo: self.itemViewTwo.leadingAnchor, constant: padding),
                        stackView.trailingAnchor.constraint(equalTo: self.itemViewTwo.trailingAnchor, constant: -padding),
                        stackView.heightAnchor.constraint(equalToConstant: 50),
                    
                    ])
                    
                    
                    stackView.axis = .horizontal
                    stackView.distribution = .equalSpacing
            //        stackView.spacing = 2 // configure spacing
                    
                    stackView.addArrangedSubview(itemInfoViewOne)
                    stackView.addArrangedSubview(itemInfoViewTwo)
                    
                    itemInfoViewOne.set(itemInfoType: .newCases, withCount: 999)
                    itemInfoViewTwo.set(itemInfoType: .activeCases, withCount: 390)
                    
                
                    
                }

            case .failure(let error): break // add error message
            }
        }
    }

    func setCountryValue(val: SingleCountryIdentityData) {
        selectedCountry = val
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))

        navigationItem.rightBarButtonItem = doneButton
    }

    func layoutUI() {
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        itemViewOne.backgroundColor = .systemPink
        itemViewTwo.backgroundColor = .systemBlue

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            ])
    }

    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }


    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
