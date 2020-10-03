//
//  ViewModel.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 02/10/2020.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var image: Image?
    @Published var error: Error?
    
    var imageURL: String? {
        didSet {
            NetworkManager.shared.downloadImage(from: imageURL!) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
    
    init() { fetchImage() }
    
    func fetchImage() {
        NetworkManager.shared.getImageURL { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
                print(error.rawValue)
            case .success(let response):
                self.imageURL = response.message
            }
        }
    }
    
}
