//
//  C19BodyLabel.swift
//  COVID-19 Statistics
//
//  Created by Chris Loreta on 7/20/22.
//

import Foundation
import UIKit

class C19BodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment){
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        font = UIFont.systemFont(ofSize: 12, weight: .regular)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
