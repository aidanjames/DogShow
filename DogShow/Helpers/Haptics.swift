//
//  Haptics.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 31/10/2020.
//

import UIKit

enum Haptics {
    static func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    static func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}
