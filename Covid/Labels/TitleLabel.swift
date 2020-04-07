//
//  TitleLabel.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor) {
        self.init(frame: .zero)
        self.text = title
        self.textColor = color
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment = .center
        font = UIFont.systemFont(ofSize: 28, weight: .bold)
    }
    
}
