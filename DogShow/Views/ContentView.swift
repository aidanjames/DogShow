//
//  ContentView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            HStack {
                ForEach(2...5, id: \.self) { i in
                    Button("\(i)") {
                        viewModel.numberOfBreeds = i
                    }
                    .padding(.horizontal)
                    .foregroundColor(viewModel.numberOfBreeds == i ? .red : .blue)
                }                
            }
            Text("Score: \(viewModel.currentScore) / \(viewModel.dogsShown)").padding()
            Button("Restart game") {
                viewModel.currentScore = 0
                viewModel.dogsShown = 0
                viewModel.newTest()
            }.padding()

            Spacer()
            if let image = viewModel.image {
                image.resizable().scaledToFit()
            } else {
                ProgressView()
            }
            Spacer()
            ButtonView(viewModel: viewModel)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
