//
//  Statistics.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import Foundation

struct Statistics: Codable, Hashable {
    let country: String?
    let countryInfo: CountryInfo?
    let cases: Int?
    let todayCases: Int?
    let deaths: Int?
    let todayDeaths: Int?
    let recovered: Int?
    let critical: Int?
    let tests: Int?
    let affectedCountries: Int?
}
