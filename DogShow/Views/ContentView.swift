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
                viewModel.fetchImage()
            }.padding()
            Button("Get breeds") {
                NetworkManager.shared.fetchDogBreeds { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(let data):
                        print(data)
                    }
                }
            }.padding()
            Spacer()
            if let image = viewModel.image {
                image.resizable().scaledToFit()
            }
            Spacer()
        }
        .onAppear {
            // Not sure what's on my mind here
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
