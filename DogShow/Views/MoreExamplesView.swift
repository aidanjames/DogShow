//
//  MoreExamplesView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 19/10/2020.
//

import SwiftUI

struct MoreExamplesView: View {
    
    var breed: Breed
    @State private var imagesUrls = [String]()
    
    let columns = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(imagesUrls, id: \.self) {
                    ImageView(imageUrl: $0)
                        .scaledToFit()
                        .cornerRadius(16)
                        .padding()
                }
            }
        }
        .onAppear {
            NetworkManager.shared.getImagesURL(for: breed) { result in
                switch result {
                case .failure(let error):
                    print(error.rawValue)
                case .success(let response):
                    self.imagesUrls = response.message
                }
            }
        }
    }
}

struct MoreExamplesView_Previews: PreviewProvider {
    static var previews: some View {
        MoreExamplesView(breed: Breed(masterBreed: "labrador"))
    }
}
