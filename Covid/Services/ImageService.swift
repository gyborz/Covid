//
//  ImageService.swift
//  Covid
//
//  Created by Gyorgy Borz on 2020. 04. 08..
//  Copyright © 2020. Gyorgy Borz. All rights reserved.
//

import UIKit

final class ImageService {
    
    static let cache = NSCache<NSString, UIImage>()
    
    private static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?)->()) -> URLSessionDataTask {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(downloadedImage, nil)
                }
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error!)
                }
            }
        }
        
        dataTask.resume()
        return dataTask
    }
    
    // we call this function whenever we want to get an image
    // if we have the image cached already then we give it back through completion and return a nil,
    // otherwise we call the private downloadImage func, and return it's dataTask
    static func getImage(withURL url: URL, completion: @escaping (_ image: UIImage?, _ error: Error?)->()) -> URLSessionDataTask? {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image, nil)
            return nil
        } else {
            return downloadImage(withURL: url, completion: completion)
        }
    }
    
}
