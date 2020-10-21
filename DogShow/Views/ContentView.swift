//
//  ContentView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 02/10/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    @State private var showingSettingsView = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Score: \(viewModel.currentScore) / \(viewModel.dogsShown) (\(viewModel.percentCorrect)%)").padding()
                
                Spacer()
                if let image = viewModel.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(16)
                        .pinchToZoom()
                } else {
                    ProgressView()
                }
                Spacer()
                ButtonView(viewModel: viewModel)
                    .padding()
                NavigationLink(destination: ReviewQuizzView(viewModel: viewModel)) {
                    Text("Review responses")
                        .padding()
                }
                .disabled(viewModel.questionsAndAnswers.isEmpty)
            }
            .navigationTitle(Text("Dog show"))
            .toolbar {
                ToolbarItem {
                    Button(action: { showingSettingsView.toggle() } ) {
                        Image(systemName: "gearshape")
                    }
                    .sheet(isPresented: $showingSettingsView) {
                        SettingsView(viewModel: viewModel)
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { viewModel.restartGame() } ) {
                        Image(systemName: "gobackward")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
