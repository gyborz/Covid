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
    private let containerView = UIView()
    private let indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        layoutUI()
        getStatistics()
    }
    
    
    private func layoutUI() {
        view.addSubview(titleLabel)
        view.addSubview(containerView)
        
        let padding: CGFloat = 15
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .tertiarySystemGroupedBackground
        containerView.layer.cornerRadius = 18
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    
    private func getStatistics() {
        showIndicator()
        NetworkManager.shared.getWorlStatistics { [weak self] result in
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
    

}
