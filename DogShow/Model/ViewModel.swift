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
    @Published var breeds = [Breed]()
    @Published var questionsAndAnswers = [QuestionAndAnswer]()
    
    @Published var displayedBreed: Breed? {
        didSet {
            fetchImage(for: displayedBreed!)
        }
    }
    
    @Published var numberOfBreeds = 4 {
        didSet { newTest() }
    }
    
    @Published var reportedImages: [String] = [] {
        didSet {
            saveReportedImages()
        }
    }
    
    var percentCorrect: Int {
        guard dogsShown > 0 else { return 0 }
        return Int((Double(currentScore) / Double(dogsShown)) * 100)
    }

    var imageURL: String? {
        didSet {
            guard !reportedImages.contains(imageURL ?? "") else {
                print("We got a reported image: \(imageURL!)")
                fetchImage(for: displayedBreed!)
                return
            }
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
    
    init() {
        newTest()
        if let badImages: [String] = FileManager.default.fetchData(from: "BadImages") {
            reportedImages = badImages
        }
    }
    
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
    
    func reportCurrentImage() {
        if let badImageUrl = imageURL {
            reportedImages.append(badImageUrl)
            newTest()
        }
    }
    
    func saveReportedImages() {
        FileManager.default.writeData(reportedImages, to: "BadImages")
    }
    
    func clearReportedImages() {
        FileManager.default.deleteData(from: "BadImages")
    }
    
    func saveCurrentGame() {
        // Save current presented image
        // Save possible breeds
        // Save questions and answers
    }
    
    func fetchCurrentGame() {
        // Load everything
    }
    
}
