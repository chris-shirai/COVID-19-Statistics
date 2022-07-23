//
//  CountryListCell.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/5/22.
//

import UIKit

// The CountryListCell is an item containing a flag and the country name. 
class CountryListCell: UICollectionViewCell {
    
    static let reuseID = "CountryListCell"
    let flagImageView = FlagImageView(frame: .zero)
    let countryNameLabel = C19TitleLabel(textAlignment: .center, fontSize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: SingleCountryIdentityData){
        countryNameLabel.text = follower.display_name
        flagImageView.image = UIImage(named: follower.code.lowercased())

    }
    
    private func configure(){
        addSubview(flagImageView)
        addSubview(countryNameLabel)
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            flagImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            flagImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            flagImageView.heightAnchor.constraint(equalTo: flagImageView.widthAnchor, constant: -40),
           
            countryNameLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 0),
            countryNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            countryNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            countryNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
       ] )

    }
    
}
