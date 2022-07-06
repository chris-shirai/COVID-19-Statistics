//
//  SearchVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/1/22.
//

import UIKit

class SearchVC: UIViewController {
    
    let countryTextField = C19TextField()
    
    var countryManager = CountryManager()

    var listOfCountries: [SingleCountryIdentityData] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBrown
        
        countryManager.initData()
        listOfCountries = countryManager.getCountryList()
        
  
    }
    
    
//    func configureCountryTextField
    

}
