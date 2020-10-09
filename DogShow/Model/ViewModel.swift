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
    @Published var currentScore = 0
    @Published var dogsShown = 0
    @Published var breeds: [Breed] = []
    @Published var displayedBreed: Breed? {
        didSet {
            fetchImage(for: displayedBreed!)
        }
    }
    
    @Published var numberOfBreeds = 4 {
        didSet { newTest() }
    }
    

    var imageURL: String? {
        didSet {
            NetworkManager.shared.downloadImage(from: imageURL!) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.image = image
                        }
                    }
                }
            }
        }
    }
    
    init() { newTest() }
    
    func newTest() {
        image = nil
        breeds = Breeds.fetchRandomBreeds(number: numberOfBreeds)
        displayedBreed = breeds.randomElement()
    }
    
    func fetchImage(for breed: Breed) {
        NetworkManager.shared.getImageURL(for: breed) { result in
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
