//
//  String+EXT.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 05/10/2020.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
