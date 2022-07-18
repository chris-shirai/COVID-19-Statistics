//
//  C19CountryInfoHeaderVC.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/17/22.
//

import UIKit

class C19CountryInfoHeaderVC: UIViewController {

    let avatarImageView = FlagImageView(frame: .zero)
    let usernameLabel = C19TitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = C19SecondaryTitleLabel(fontSize: 18)

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
        
        avatarImageView.image = UIImage(named: identityData.code.lowercased())
        usernameLabel.text = identityData.display_name
        
        if(covidData?.response != nil && !covidData.response.isEmpty) {
            nameLabel.text = "Population: \(covidData.response[0].population)"
        } else {
            print("returned empty")
        }

    }

    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
    }

    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            ])

    }



}
