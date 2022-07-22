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

    let titleLabel = C19SecondaryTitleLabel(textAlignment: .center, fontSize: 14)
    let countLabel = C19TitleLabel(textAlignment: .center, fontSize: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureBackgroundView()
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(titleLabel)
        addSubview(countLabel)

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
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
