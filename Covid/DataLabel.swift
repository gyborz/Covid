//
//  DataLabel.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class DataLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor) {
        self.init(frame: .zero)
        self.text = "0"
        self.textColor = color
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .body)
        textAlignment = .center
    }
    
}
