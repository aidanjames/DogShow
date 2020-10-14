//
//  ReviewQuizzView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 13/10/2020.
//

import SwiftUI

struct ReviewQuizzView: View {
    @ObservedObject var viewModel: ViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.questionsAndAnswers) {
                        GuessView(questionAndAnswer: $0)
                    }
                    .navigationTitle(Text("Answers!"))
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
