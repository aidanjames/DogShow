//
//  NetworkManager.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 02/10/2020.
//

import SwiftUI
import UIKit

enum NetworkError: String, Error {
    case invalidURL = "Sorry, the URL doesn't exist."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
}



class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://dog.ceo/api/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    
    func getImageURL(for breed: Breed, completed: @escaping (Result<DogAPIResponse, NetworkError>) -> Void) {
        
        let fullURLString = baseURL + "breed/\(breed.urlString)/images/random"
        
        guard let url = URL(string: fullURLString) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let imageURL = try decoder.decode(DogAPIResponse.self, from: data)
                completed(.success(imageURL))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (Image?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(Image(uiImage: image))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(Image(uiImage: image))
        }
        task.resume()
    }
    
    
}
