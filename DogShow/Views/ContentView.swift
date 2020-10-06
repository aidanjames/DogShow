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
            Button("Another one please") {
                viewModel.newTest()
            }.padding()

            Spacer()
            if let image = viewModel.image {
                image.resizable().scaledToFit()
            } else {
                ProgressView()
            }
            Spacer()
            ForEach(viewModel.breeds) { breed in
                Text(breed.displayName)
                    .foregroundColor(breed.displayName == viewModel.displayedBreed?.displayName ? .red : .blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
