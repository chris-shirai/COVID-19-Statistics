//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {

    let headerView = UIView()
    
    var selectedCountry: SingleCountryIdentityData!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))

        navigationItem.rightBarButtonItem = doneButton

        layoutUI()
        getUserInfo()

    }

    func getUserInfo() {
        NetworkManager.shared.getCountryCovidData(for: selectedCountry.api_name) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let countryCovidData):
                DispatchQueue.main.async {
                    self.add(childVC: C19CountryInfoHeaderVC(covidData: countryCovidData, identityData: self.selectedCountry), to: self.headerView)
                }

            case .failure(let error): break // add error message
            }
        }
    }

    func setCountryValue(val: SingleCountryIdentityData) {
        selectedCountry = val
    }

    func layoutUI() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
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
