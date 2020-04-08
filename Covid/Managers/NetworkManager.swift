//
//  NetworkManager.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 07..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

enum CovidError: String, Error {
    case errorHappened = "Error"
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://corona.lmao.ninja/"
    
    private init() {}
    
    func getWorlStatistics(completed: @escaping (Result<Statistics,CovidError>) -> Void) {
        let endpoint = baseURL + "all"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.errorHappened))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.errorHappened))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.errorHappened))
                return
            }
            
            guard let data = data else {
                completed(.failure(.errorHappened))
                return
            }
            
            do {
                let statistics = try JSONDecoder().decode(Statistics.self, from: data)
                completed(.success(statistics))
            } catch {
                completed(.failure(.errorHappened))
            }
        }
        
        task.resume()
    }
    
    func getCountriesStatistics(completed: @escaping (Result<[Statistics],CovidError>) -> Void) {
        let endpoint = baseURL + "countries"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.errorHappened))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.errorHappened))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.errorHappened))
                return
            }
            
            guard let data = data else {
                completed(.failure(.errorHappened))
                return
            }
            
            do {
                let countriesStatistics = try JSONDecoder().decode([Statistics].self, from: data)
                completed(.success(countriesStatistics))
            } catch {
                completed(.failure(.errorHappened))
            }
        }
        
        task.resume()
    }
    
}
