//
//  StatisticsViewController.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 08..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    private var statistics: Statistics
    
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
    
    private let casesDataLabel = DataLabel(color: .systemOrange)
    private let todayCasesDataLabel = DataLabel(color: .systemOrange)
    private let deathsDataLabel = DataLabel(color: .systemRed)
    private let todayDeathsDataLabel = DataLabel(color: .systemRed)
    private let recoveredDataLabel = DataLabel(color: .systemGreen)
    private let criticalDataLabel = DataLabel(color: .systemOrange)
    private let testsDataLabel = DataLabel(color: .systemBlue)
    private let affectedCountriesDataLabel = DataLabel(color: .systemOrange)
    
    init(statistics: Statistics) {
        self.statistics = statistics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutUI()
        configureStackViews()
        updateUI(with: statistics)
    }
    
    
    private func layoutUI() {
        view.addSubview(mainStackView)
        let innerPadding: CGFloat = 10
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: innerPadding),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -innerPadding),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -innerPadding)
        ])
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
        
        dataStackView.addArrangedSubview(casesDataLabel)
        dataStackView.addArrangedSubview(todayCasesDataLabel)
        dataStackView.addArrangedSubview(deathsDataLabel)
        dataStackView.addArrangedSubview(todayDeathsDataLabel)
        dataStackView.addArrangedSubview(recoveredDataLabel)
        dataStackView.addArrangedSubview(criticalDataLabel)
        dataStackView.addArrangedSubview(testsDataLabel)
        
        mainStackView.addArrangedSubview(titlesStackView)
        mainStackView.addArrangedSubview(dataStackView)
        
        if statistics.affectedCountries != nil {
            titlesStackView.addArrangedSubview(affectedCountriesLabel)
            dataStackView.addArrangedSubview(affectedCountriesDataLabel)
        }
        
        titlesStackView.translatesAutoresizingMaskIntoConstraints = false
        dataStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titlesStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.7),
            dataStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    
    private func updateUI(with statistics: Statistics) {
        casesDataLabel.text = statistics.cases != nil ? String(statistics.cases!) : "N/A"
        todayCasesDataLabel.text = statistics.todayCases != nil ? String(statistics.todayCases!) : "N/A"
        deathsDataLabel.text = statistics.deaths != nil ? String(statistics.deaths!) : "N/A"
        todayDeathsDataLabel.text = statistics.todayDeaths != nil ? String(statistics.todayDeaths!) : "N/A"
        recoveredDataLabel.text = statistics.recovered != nil ? String(statistics.recovered!) : "N/A"
        criticalDataLabel.text = statistics.critical != nil ? String(statistics.critical!) : "N/A"
        testsDataLabel.text = statistics.tests != nil ? String(statistics.tests!) : "N/A"
        affectedCountriesDataLabel.text = statistics.affectedCountries != nil ? String(statistics.affectedCountries!) : "N/A"
    }

}
