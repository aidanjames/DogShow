//
//  ButtonView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 07/10/2020.
//

import SwiftUI

struct ButtonView: View {
    
    var breeds: [Breed]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(breeds) { dog in
                Text("\(dog.displayName)")
            }
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(breeds: [Breed(masterBreed: "labrador"), Breed(masterBreed: "Poodle"), Breed(masterBreed: "Golden Retriever"), Breed(masterBreed: "Golden Retriever"), Breed(masterBreed: "Golden Retriever"), Breed(masterBreed: "Golden Retriever"), Breed(masterBreed: "Golden Retriever")])
    }
}
