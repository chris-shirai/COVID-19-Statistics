//
//  FavoriteCell.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/28/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavoriteCell"
    let flagImageView = FlagImageView(frame: .zero)
    let countryNameLabel = C19TitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: SingleCountryIdentityData){
        countryNameLabel.text = favorite.display_name
        flagImageView.image = UIImage(named: favorite.code.lowercased())

    }
    
    private func configure() {
        addSubview(flagImageView)
        addSubview(countryNameLabel)
        
        let padding: CGFloat = 12
        let flagWidth: CGFloat = 90

        
        NSLayoutConstraint.activate([
            flagImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            flagImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            flagImageView.widthAnchor.constraint(equalToConstant: flagWidth),
            flagImageView.heightAnchor.constraint(equalToConstant: flagWidth * Constants.flagWidthHeightRatio),
            
            countryNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            countryNameLabel.leadingAnchor.constraint(equalTo: flagImageView.trailingAnchor, constant: 24),
            countryNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            countryNameLabel.heightAnchor.constraint(equalToConstant: 40)

        ])
    }
    
}
