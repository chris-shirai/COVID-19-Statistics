//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {

    var x: NetworkManager = NetworkManager()
    
    var selectedCountry: SingleCountryIdentityData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
        
        x.getCountryCovidData(countryApiName: selectedCountry.api_name)
    }
    
    
    func setCountryValue(val: SingleCountryIdentityData){
        selectedCountry = val
    }
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
