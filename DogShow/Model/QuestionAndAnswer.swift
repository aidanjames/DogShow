//
//  Question.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 13/10/2020.
//

import Foundation

struct QuestionAndAnswer: Identifiable, Codable {
    var id = UUID()
    var presentedImageUrl: String
    var guessedBreed: Breed
    var correctBreed: Breed
}
