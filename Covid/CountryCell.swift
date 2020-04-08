//
//  CountryCell.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 08..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class CountryCell: UICollectionViewCell {
    
    static let reuseID = "CountryCell"
    let flagImageView = UIImageView(frame: .zero)
    let countryLabel = UILabel()
    private var imageTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(flagImageView)
        addSubview(countryLabel)
        
        let padding: CGFloat = 8
        
        flagImageView.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            flagImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            flagImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            flagImageView.heightAnchor.constraint(equalTo: flagImageView.widthAnchor),
            
            countryLabel.topAnchor.constraint(equalTo: flagImageView.bottomAnchor, constant: 12),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            countryLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupUI() {
        flagImageView.layer.cornerRadius = 14
        flagImageView.clipsToBounds = true
        flagImageView.contentMode = .scaleAspectFill
        
        countryLabel.textAlignment = .center
        countryLabel.font = UIFont.preferredFont(forTextStyle: .body)
        countryLabel.textColor = .label
        countryLabel.adjustsFontSizeToFitWidth = true
        countryLabel.minimumScaleFactor = 0.9
    }
    
    func set(country: Statistics, for indexPath: IndexPath) {
        countryLabel.text = country.country
        
        if let imageURL = country.countryInfo?.flag {
            guard let url = URL(string: imageURL) else { return }
            if imageTask == nil {
                imageTask = ImageService.getImage(withURL: url) { (image, error) in
                    if error != nil && error!._code != NSURLErrorCancelled {
                        //self.flagImageView.image = UIImage(named: "error")
                    } else {
                        self.flagImageView.image = image
                    }
                }
            }
        } else {
            //self.flagImageView.image = UIImage(named: "error")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageTask?.cancel()
        imageTask = nil
        flagImageView.image = nil
    }
    
}
