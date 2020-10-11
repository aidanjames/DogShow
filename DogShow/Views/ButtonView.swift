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
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(16)
                            .opacity(!showingFeedback ? 1 : dog.displayName == viewModel.displayedBreed?.displayName ? 1 : 0.5)
                    }
                }
            }

            Button("Report image") {
                viewModel.reportCurrentImage()
            }.padding()
            Button("Print bad images") {
                for imageUrl in viewModel.reportedImages {
                    print(imageUrl)
                }
            }.padding()
            Button("Delete bad images") {
                viewModel.reportedImages.removeAll()
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(viewModel: ViewModel())
    }
}


//.foregroundColor(dog.displayName == viewModel.displayedBreed?.displayName ? .red : .primary)
