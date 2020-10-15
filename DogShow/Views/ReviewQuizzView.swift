//
//  ReviewQuizzView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 13/10/2020.
//

import SwiftUI

struct ReviewQuizzView: View {
    @ObservedObject var viewModel: ViewModel
    
    @State private var filterCriteria = 0
    
    var filteredQuestionAndAnswers: [QuestionAndAnswer] {
        if filterCriteria == 1 {
            return viewModel.questionsAndAnswers.filter { $0.guessedBreed.displayName == $0.correctBreed.displayName }
        } else if filterCriteria == 2 {
            return viewModel.questionsAndAnswers.filter { $0.guessedBreed.displayName != $0.correctBreed.displayName }
        }
        return viewModel.questionsAndAnswers
    }
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $filterCriteria.animation(), label: Text("Filter by")) {
                                Text("All").tag(0)
                                Text("Correct").tag(1)
                                Text("Incorrect").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(filteredQuestionAndAnswers) {
                            GuessView(questionAndAnswer: $0)
                        }
                        .navigationTitle(Text("Answers!"))
                    }
                }

            }
        }
    }

}

struct ReviewQuizzView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewQuizzView(viewModel: ViewModel())
    }
}
