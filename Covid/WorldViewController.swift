//
//  WorldViewController.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class WorldViewController: UIViewController {
    
    private let titleLabel = TitleLabel(title: "World statistics", color: .systemPink)
    
    private let contentView = UIView()
    
    private let mainStackView = UIStackView()
    private let titlesStackView = UIStackView()
    private let dataStackView = UIStackView()
    
    private let casesLabel = StatTitleLabel(title: "Number of cases so far:")
    private let todayCasesLabel = StatTitleLabel(title: "Number of cases today:")
    private let deathsLabel = StatTitleLabel(title: "Number of deaths so far:")
    private let todayDeathsLabel = StatTitleLabel(title: "Number of deaths today:")
    private let recoveredLabel = StatTitleLabel(title: "Number of recovered patients:")
    private let criticalLabel = StatTitleLabel(title: "Number of patients in critical state:")
    private let testsLabel = StatTitleLabel(title: "Number of tests so far:")
    private let affectedCountriesLabel = StatTitleLabel(title: "Number of affected countries:")
    
    private let casesDataLabel = DataLabel(color: .systemYellow)
    private let todayCasesDataLabel = DataLabel(color: .systemYellow)
    private let deathsDataLabel = DataLabel(color: .systemRed)
    private let todayDeathsDataLabel = DataLabel(color: .systemRed)
    private let recoveredDataLabel = DataLabel(color: .systemGreen)
    private let criticalDataLabel = DataLabel(color: .systemYellow)
    private let testsDataLabel = DataLabel(color: .systemBlue)
    private let affectedCountriesDataLabel = DataLabel(color: .systemYellow)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutUI()
        configureStackViews()
    }
    
    private func configureStackViews() {
        mainStackView.axis = .horizontal
        
        titlesStackView.axis = .vertical
        titlesStackView.distribution = .fillEqually
        
        dataStackView.axis = .vertical
        dataStackView.distribution = .fillEqually
        
        titlesStackView.addArrangedSubview(casesLabel)
        titlesStackView.addArrangedSubview(todayCasesLabel)
        titlesStackView.addArrangedSubview(deathsLabel)
        titlesStackView.addArrangedSubview(todayDeathsLabel)
        titlesStackView.addArrangedSubview(recoveredLabel)
        titlesStackView.addArrangedSubview(criticalLabel)
        titlesStackView.addArrangedSubview(testsLabel)
        titlesStackView.addArrangedSubview(affectedCountriesLabel)
        
        dataStackView.addArrangedSubview(casesDataLabel)
        dataStackView.addArrangedSubview(todayCasesDataLabel)
        dataStackView.addArrangedSubview(deathsDataLabel)
        dataStackView.addArrangedSubview(todayDeathsDataLabel)
        dataStackView.addArrangedSubview(recoveredDataLabel)
        dataStackView.addArrangedSubview(criticalDataLabel)
        dataStackView.addArrangedSubview(testsDataLabel)
        dataStackView.addArrangedSubview(affectedCountriesDataLabel)
        
        mainStackView.addArrangedSubview(titlesStackView)
        mainStackView.addArrangedSubview(dataStackView)
        
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titlesStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
            dataStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(contentView)
        contentView.addSubview(mainStackView)
        
        let padding: CGFloat = 15
        let innerPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .secondarySystemGroupedBackground
        contentView.layer.cornerRadius = 18
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: innerPadding),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -innerPadding),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -innerPadding)
        ])
    }

}
