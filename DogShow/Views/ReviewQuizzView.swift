//
//  ReviewQuizzView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 13/10/2020.
//

import SwiftUI

struct ReviewQuizzView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(viewModel.questionsAndAnswers) {
                    Text("You guessed: \($0.guessedBreed.displayName)")
                    Text("Correct answer: \($0.correctBreed.displayName)")
                }
                .navigationTitle(Text("Answers!"))
            }
        }
    }
}

struct ReviewQuizzView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewQuizzView(viewModel: ViewModel())
    }
}
