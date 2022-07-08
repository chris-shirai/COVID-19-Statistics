//
//  DashboardVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 6/30/22.
//

import UIKit

class DashboardVC: UIViewController {

    var display_name: String!
    var x: NetworkManager = NetworkManager()
    
    var selectedCountry: SingleCountryIdentityData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
//        print(display_name!)
        
        x.getCountryCovidData(countryApiName: selectedCountry.api_name)
//        x.getData()
    }
    
    
    func setCountryValue(val: SingleCountryIdentityData){
        selectedCountry = val
    }
    

    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
