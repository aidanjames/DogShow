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
            Spacer()
            if let image = viewModel.image {
                image.resizable().scaledToFit()
            }
            Spacer()
        }
        .onAppear {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
