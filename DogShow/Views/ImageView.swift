//
//  ImageView.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 14/10/2020.
//

import SwiftUI

struct ImageView: View {
    @State private var image: Image?
    var imageUrl: String
    
    var body: some View {
        if image != nil {
            image!
                .resizable()
//                .scaledToFit()
                .frame(maxWidth: .infinity)
        } else {
            ProgressView()
                .onAppear {
                    NetworkManager.shared.downloadImage(from: imageUrl) { image in
                        if let image = image {
                            DispatchQueue.main.async {
                                self.image = image
                            }
                        }
                    }
                }
        }
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageUrl: "https://images.dog.ceo/breeds/spaniel-sussex/n02102480_4923.jpg")
    }
}
