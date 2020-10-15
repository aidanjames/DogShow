//
//  ContentView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    @State private var showingReviewScreen = false
    
    var body: some View {
        VStack {
            HStack {
                ForEach(2...6, id: \.self) { i in
                    if i.isMultiple(of: 2) {
                        Button("\(i)") {
                            viewModel.numberOfBreeds = i
                        }
                        .padding(.horizontal)
                        .foregroundColor(viewModel.numberOfBreeds == i ? .red : .blue)
                    }
                }                
            }
            Text("Score: \(viewModel.currentScore) / \(viewModel.dogsShown) (\(viewModel.percentCorrect)%)").padding()
                
            Button("Restart game") {
                viewModel.restartGame()
            }.padding()
            
            Spacer()
            if let image = viewModel.image {
                image.resizable().scaledToFit()
            } else {
                ProgressView()
            }
            Spacer()
            ButtonView(viewModel: viewModel, showingReviewScreen: $showingReviewScreen)
                .padding()
        }
        .sheet(isPresented: $showingReviewScreen) {
            ReviewQuizzView(viewModel: viewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
