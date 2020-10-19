//
//  GuessView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 14/10/2020.
//

import SwiftUI

struct GuessView: View {
    var questionAndAnswer: QuestionAndAnswer
    
    var answerWasCorrect: Bool { questionAndAnswer.correctBreed.displayName == questionAndAnswer.guessedBreed.displayName }
    
    @State private var showingMoreExamples = false
    
    var body: some View {
        ZStack {
            answerWasCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
                VStack(alignment: .leading) {
                    ImageView(imageUrl: questionAndAnswer.presentedImageUrl).scaledToFit()
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(questionAndAnswer.guessedBreed.displayName)")
                                .foregroundColor(answerWasCorrect ? .green : .red)
                            Text("\(answerWasCorrect ? "" : questionAndAnswer.correctBreed.displayName)")

                        }
                        Spacer()
                        Button(action: { showingMoreExamples.toggle() }) {
                            Text("More...")
                                .foregroundColor(.white)
                                .font(.caption)
                                .padding(5)
                                .background(Color.blue)
                                .cornerRadius(16)
                        }
                        .padding(5)
                        .sheet(isPresented: $showingMoreExamples) {
                            MoreExamplesView(breed: questionAndAnswer.correctBreed)
                        }
                    }
                }
                .font(.caption)
        }
        .frame(maxWidth: .infinity, minHeight: 200, maxHeight: 200)
    }
}

struct GuessView_Previews: PreviewProvider {
    static var previews: some View {
        GuessView(questionAndAnswer: QuestionAndAnswer(presentedImageUrl: "https://images.dog.ceo/breeds/spaniel-sussex/n02102480_4923.jpg", guessedBreed: Breed(masterBreed: "Leonberg"), correctBreed: Breed(masterBreed: "Curly Retriever")))
    }
}
