//
//  CountryViewController.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 08..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    
    private var statistics: Statistics
    
    private let containerView = UIView()
    private let indicator = UIActivityIndicatorView()
    
    init(statistics: Statistics) {
        self.statistics = statistics
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getStatistics()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    private func layoutUI() {
        view.addSubview(containerView)
        
        let padding: CGFloat = 15
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .tertiarySystemGroupedBackground
        containerView.layer.cornerRadius = 18
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func getStatistics() {
        showIndicator()
        NetworkManager.shared.getCountryStatistics(for: statistics.countryInfo!._id!) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let statistics):
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.setupChildVC(with: statistics)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.hideIndicator()
                    let alert = UIAlertController(title: error.rawValue, message: nil, preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
    private func setupChildVC(with statistics: Statistics) {
        let childVC = StatisticsViewController(statistics: statistics)
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
    private func showIndicator() {
        containerView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .large
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: containerView.topAnchor),
            indicator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            indicator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            indicator.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        indicator.startAnimating()
    }
    
    
    private func hideIndicator() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

}
