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
    
    private let casesDataLabel = UILabel()
    private let todayCasesDataLabel = UILabel()
    private let deathsDataLabel = UILabel()
    private let todayDeathsDataLabel = UILabel()
    private let recoveredDataLabel = UILabel()
    private let criticalDataLabel = UILabel()
    private let testsDataLabel = UILabel()
    private let affectedCountriesDataLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutUI()
        configureStackViews()
    }
    
    private func configureStackViews() {
        mainStackView.axis = .horizontal
        mainStackView.distribution = .equalSpacing
        
        titlesStackView.axis = .vertical
        titlesStackView.distribution = .equalSpacing
        
        dataStackView.axis = .vertical
        dataStackView.distribution = .equalSpacing
        
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
    }
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(mainStackView)
        
        let padding: CGFloat = 25
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
        
    }

}
