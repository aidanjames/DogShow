//
//  ButtonView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 07/10/2020.
//

import SwiftUI

struct ButtonView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State private var showingFeedback = false
    @State private var answerWasCorrect = false
    @Binding var showingReviewScreen: Bool
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            Text("\(answerWasCorrect ? "Correct!" : "Wrong")")
                .font(.largeTitle)
                .bold()
                .foregroundColor(answerWasCorrect ? .green : .red)
                .opacity(showingFeedback ? 1 : 0)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.breeds) { dog in
                    Button(action: {
                        withAnimation {
                            showingFeedback = true
                            viewModel.questionsAndAnswers.append(QuestionAndAnswer(presentedImageUrl: viewModel.imageURL!, guessedBreed: dog, correctBreed: viewModel.displayedBreed!))
                            if dog.displayName == viewModel.displayedBreed?.displayName {
                                answerWasCorrect = true
                                viewModel.currentScore += 1
                                viewModel.dogsShown += 1
                            } else {
                                answerWasCorrect = false
                                viewModel.dogsShown += 1
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                showingFeedback = false
                                viewModel.newTest()
                            }
                        }
                    }) {
                        Text("\(dog.displayName)")
                            
                            .foregroundColor(.white)
//                            .frame(width: 150, height: 50)
                            .frame(minWidth: 150, maxWidth: 200, minHeight: 50, maxHeight: 60)
                            .background(Color.blue)
                            .cornerRadius(16)
                            .opacity(!showingFeedback ? 1 : dog.displayName == viewModel.displayedBreed?.displayName ? 1 : 0.5)
                    }
                }
            }
            
            //            Button("Report image") {
            //                viewModel.reportCurrentImage()
            //            }.padding()
            //            HStack {
            //                Text("\(viewModel.reportedImages.count) reported images")
            //                Button("Clear") {
            //                    for imageUrl in viewModel.reportedImages {
            //                        print("Deleting: \(imageUrl)")
            //                    }
            //                    viewModel.reportedImages.removeAll()
            //                }
            //            }.padding()
            Button("Show review screen") {
                showingReviewScreen.toggle()
            }
            .disabled(viewModel.questionsAndAnswers.isEmpty)
            .padding()
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(viewModel: ViewModel(), showingReviewScreen: .constant(false))
    }
}


