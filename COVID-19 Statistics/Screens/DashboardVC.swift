//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {
    
    let headerView = UIView()

//    var x: NetworkManager = NetworkManager()
    
    var selectedCountry: SingleCountryIdentityData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
        
        layoutUI()
        
        
getUserInfo()
        
//        x.getCountryCovidData(countryApiName: selectedCountry.api_name)
        
//        self.add(childVC: C19CountryInfoHeaderVC(), to: self.headerView)
        

    }
    
    func getUserInfo(){
        NetworkManager.shared.getCountryCovidData(for: selectedCountry.api_name) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    
                    self.add(childVC: C19CountryInfoHeaderVC(), to: self.headerView)

//                    self.configureUIElements(with: user)
                    
                    
                }
                
            case .failure(let error):
                var x = 1
//                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: CountryCovidData) {
//        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
//        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
//        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
//        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func setCountryValue(val: SingleCountryIdentityData){
        selectedCountry = val
    }
    
    func layoutUI(){
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints=false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
