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
    let locationImageView = UIImageView()
    let locationLabel = C19SecondaryTitleLabel(fontSize: 18)
    let bioLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        configureUIElements()
    }

    
    func configureUIElements(){
        avatarImageView.image = UIImage(named: "us")
        usernameLabel.text = "test username"
        nameLabel.text = "test name"
        locationLabel.text = "location"
        bioLabel.text="bio"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = .secondaryLabel
    }
    
    func addSubviews() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
//        view.addSubview(locationImageView)
//        view.addSubview(locationLabel)
//        view.addSubview(bioLabel)

    }

    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
//            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
//            locationImageView.widthAnchor.constraint(equalToConstant: 20),
//            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
//            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
//            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
//            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
//            locationLabel.heightAnchor.constraint(equalToConstant: 20),
//
//            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
//            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
//            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
//            bioLabel.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
    }



}
