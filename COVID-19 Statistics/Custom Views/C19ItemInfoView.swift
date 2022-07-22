//
//  C19ItemInfoView.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/17/22.
//

import UIKit

enum ItemInfoType {
    case newCases, activeCases, newDeaths, totalDeaths, recoveredCases, totalCases
}

class C19ItemInfoView: UIView {

    var titleLabel: C19SecondaryTitleLabel!
    var countLabel: C19TitleLabel!
    
    var height: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundView()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(itemView: UIView){
        height = itemView.bounds.height
        super.init(frame: .zero)
        configureBackgroundView()
        configure()
        
    }

    private func configure() {
        
        titleLabel = C19SecondaryTitleLabel(textAlignment: .center, fontSize: height/5)
        countLabel = C19TitleLabel(textAlignment: .center, fontSize: height/5)
        
        addSubview(titleLabel)
        addSubview(countLabel)

        NSLayoutConstraint.activate([

            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -(height / 5)),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: height/12),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18)
            ])
    }

    func set(itemInfoType: ItemInfoType, withCount count: String) {
        switch itemInfoType {
        case .newCases:
            titleLabel.text = "New Cases"
        case .activeCases:
            titleLabel.text = "Active Cases"
        case .newDeaths:
            titleLabel.text = "New Deaths"
        case .totalDeaths:
            titleLabel.text = "Total Deaths"
        case .recoveredCases:
            titleLabel.text = "Recovered Cases"
        case .totalCases:
            titleLabel.text = "Total Cases"
        }

        countLabel.text = count
    }

    private func configureBackgroundView() {
        self.layer.cornerRadius = 18
        self.backgroundColor = .secondarySystemBackground
    }
}
