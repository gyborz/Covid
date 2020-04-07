//
//  CovidTabBarController.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

class CovidTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [createWorldVC(), createCountriesVC()]
    }
    
    private func createWorldVC() -> WorldViewController {
        let worldVC = WorldViewController()
        worldVC.tabBarItem = UITabBarItem(title: "World", image: UIImage(systemName: "globe"), tag: 0)
        
        return worldVC
    }
    
    private func createCountriesVC() -> UINavigationController {
        let countriesVC = CountriesViewController()
        countriesVC.title = "Countries"
        countriesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: countriesVC)
    }

}
