//
//  SettingsView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 20/10/2020.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var numberOfPossibleBreeds = 2
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of dogs to guess from")) {
                    Stepper(value: $numberOfPossibleBreeds, in: 2...6, step: 2) {
                        Text("Possible dogs: \(numberOfPossibleBreeds)")
                    }
                    .onAppear {
                        numberOfPossibleBreeds = viewModel.numberOfBreeds
                    }
                }
            }
            .navigationTitle(Text("Settings"))
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        viewModel.numberOfBreeds = numberOfPossibleBreeds
                        // The following doesn't appear to work wtf?
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
    
    func save() {
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: ViewModel())
    }
}
