//
//  C19CountryInfoHeaderVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/17/22.
//

import UIKit

// The C19CountryInfoHeaderVC is the header in the dashboard view (showing statistics) - it contains a flag image, the country name, and population labels
class C19CountryInfoHeaderVC: UIViewController {

    let flagImageView = FlagImageView(frame: .zero)
    let countryNameLabel = C19TitleLabel(textAlignment: .left, fontSize: 34)
    let populationLabel = C19SecondaryTitleLabel(textAlignment: .left, fontSize: 18)

    var covidData: CountryCovidData!
    var identityData: SingleCountryIdentityData!

    init(covidData: CountryCovidData, identityData: SingleCountryIdentityData) {
        super.init(nibName: nil, bundle: nil)
        self.covidData = covidData
        self.identityData = identityData
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }


    func configureUIElements() {

        flagImageView.image = UIImage(named: identityData.code.lowercased())
        countryNameLabel.text = identityData.display_name

        if(covidData?.response != nil && !covidData.response.isEmpty) {

            var population: String

            if(covidData.response[0].population != nil) {
                population = UIHelper.formatNumber(int: covidData.response[0].population!)
            } else {
                population = "--"
            }


            populationLabel.text = "Population: \(population)"
        } else {
            print("returned empty")
        }

    }

    func addSubviews() {
        view.addSubview(flagImageView)
        view.addSubview(countryNameLabel)
        view.addSubview(populationLabel)
    }

    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        
        let flagWidth: CGFloat = 130


        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            flagImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            flagImageView.widthAnchor.constraint(equalToConstant: flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: flagWidth * Constants.flagWidthHeightRatio),

            countryNameLabel.topAnchor.constraint(equalTo: flagImageView.topAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: textImagePadding),
            countryNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 38),

            populationLabel.centerYAnchor.constraint(equalTo: flagImageView.centerYAnchor, constant: 8),
            populationLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: textImagePadding),
            populationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            populationLabel.heightAnchor.constraint(equalToConstant: 20),
            ])

    }



}
