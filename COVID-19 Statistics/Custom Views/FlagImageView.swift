//
//  FlagImageView.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/5/22.
//

import UIKit

class FlagImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // prevents sharp corners
        translatesAutoresizingMaskIntoConstraints = false

        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.systemGray.cgColor
    }
}
