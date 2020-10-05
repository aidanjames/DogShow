//
//  DogBreeds.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 03/10/2020.
//

import Foundation

struct DogBreed: Codable, Identifiable {
    var id = UUID()
    var masterBreed: MasterBreed
    var subBreed: SubBreed?
    var displayName: String { (subBreed != nil ? subBreed!.subBreedName.capitalizingFirstLetter() : "") + masterBreed.masterBreedName.capitalizingFirstLetter() }
    var urlString: String { return masterBreed.masterBreedName + (subBreed != nil ? "/\(subBreed!.subBreedName)" : "") }
}

struct MasterBreed: Codable, Identifiable {
    var id = UUID()
    var masterBreedName: String
    var subBreeds: [SubBreed]
}

struct SubBreed: Codable, Identifiable {
    var id = UUID()
    var masterBreed: MasterBreed
    var subBreedName: String
}

struct BreedListResponse: Codable {
    var message: [String]
}



