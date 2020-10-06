//
//  DogBreeds.swift
//  DogShow
//
//  Created by Aidan Pendlebury on 03/10/2020.
//

import Foundation


struct Breed: Codable, Identifiable {
    var id = UUID()
    var masterBreed: String
    var subBreed: String?
    var displayName: String { (subBreed != nil ? subBreed!.capitalizingFirstLetter() : "") + " \(masterBreed.capitalizingFirstLetter())" }
    var urlString: String { return masterBreed + (subBreed != nil ? "/\(subBreed!)" : "") }
    
    static func makeBreed(master: String, sub: String?) -> Breed {
        return Breed(masterBreed: master, subBreed: sub)
    }
}


enum Breeds {
    
    private static let allBreeds: [String: [String]] =
        ["affenpinscher": [],
        "african": [],
        "airedale": [],
        "akita": [],
        "appenzeller": [],
        "australian": [
            "shepherd"
        ],
        "basenji": [],
        "beagle": [],
        "bluetick": [],
        "borzoi": [],
        "bouvier": [],
        "boxer": [],
        "brabancon": [],
        "briard": [],
        "buhund": [
            "norwegian"
        ],
        "bulldog": [
            "boston",
            "english",
            "french"
        ],
        "bullterrier": [
            "staffordshire"
        ],
        "cairn": [],
        "cattledog": [
            "australian"
        ],
        "chihuahua": [],
        "chow": [],
        "clumber": [],
        "cockapoo": [],
        "collie": [
            "border"
        ],
        "coonhound": [],
        "corgi": [
            "cardigan"
        ],
        "cotondetulear": [],
        "dachshund": [],
        "dalmatian": [],
        "dane": [
            "great"
        ],
        "deerhound": [
            "scottish"
        ],
        "dhole": [],
        "dingo": [],
        "doberman": [],
        "elkhound": [
            "norwegian"
        ],
        "entlebucher": [],
        "eskimo": [],
        "finnish": [
            "lapphund"
        ],
        "frise": [
            "bichon"
        ],
        "germanshepherd": [],
        "greyhound": [
            "italian"
        ],
        "groenendael": [],
        "havanese": [],
        "hound": [
            "afghan",
            "basset",
            "blood",
            "english",
            "ibizan",
            "plott",
            "walker"
        ],
        "husky": [],
        "keeshond": [],
        "kelpie": [],
        "komondor": [],
        "kuvasz": [],
        "labrador": [],
        "leonberg": [],
        "lhasa": [],
        "malamute": [],
        "malinois": [],
        "maltese": [],
        "mastiff": [
            "bull",
            "english",
            "tibetan"
        ],
        "mexicanhairless": [],
        "mix": [],
        "mountain": [
            "bernese",
            "swiss"
        ],
        "newfoundland": [],
        "otterhound": [],
        "ovcharka": [
            "caucasian"
        ],
        "papillon": [],
        "pekinese": [],
        "pembroke": [],
        "pinscher": [
            "miniature"
        ],
        "pitbull": [],
        "pointer": [
            "german",
            "germanlonghair"
        ],
        "pomeranian": [],
        "poodle": [
            "miniature",
            "standard",
            "toy"
        ],
        "pug": [],
        "puggle": [],
        "pyrenees": [],
        "redbone": [],
        "retriever": [
            "chesapeake",
            "curly",
            "flatcoated",
            "golden"
        ],
        "ridgeback": [
            "rhodesian"
        ],
        "rottweiler": [],
        "saluki": [],
        "samoyed": [],
        "schipperke": [],
        "schnauzer": [
            "giant",
            "miniature"
        ],
        "setter": [
            "english",
            "gordon",
            "irish"
        ],
        "sheepdog": [
            "english",
            "shetland"
        ],
        "shiba": [],
        "shihtzu": [],
        "spaniel": [
            "blenheim",
            "brittany",
            "cocker",
            "irish",
            "japanese",
            "sussex",
            "welsh"
        ],
        "springer": [
            "english"
        ],
        "stbernard": [],
        "terrier": [
            "american",
            "australian",
            "bedlington",
            "border",
            "dandie",
            "fox",
            "irish",
            "kerryblue",
            "lakeland",
            "norfolk",
            "norwich",
            "patterdale",
            "russell",
            "scottish",
            "sealyham",
            "silky",
            "tibetan",
            "toy",
            "westhighland",
            "wheaten",
            "yorkshire"
        ],
        "vizsla": [],
        "waterdog": [
            "spanish"
        ],
        "weimaraner": [],
        "whippet": [],
        "wolfhound": [
            "irish"
        ]
    ]
    
    static func fetchRandomBreeds(number: Int) -> [Breed] {
        var returnArray = [Breed]()
        
        while returnArray.count < number {
            // get a random breed
            let randomMasterBreed: String = allBreeds.randomElement()!.key
            
            // if it's already in the array try again
            if returnArray.contains(where: { $0.masterBreed == randomMasterBreed } ) { continue }
            
            // if the master breed doesn't have any sub-breeds, add the breed to the return array
            if allBreeds[randomMasterBreed]!.isEmpty {
                returnArray.append(Breed(masterBreed: randomMasterBreed))
            } else {
                // get a random sub-breed and add it to the return array
                let randomSubBreed = allBreeds[randomMasterBreed]!.randomElement()!
                returnArray.append(Breed(masterBreed: randomMasterBreed, subBreed: randomSubBreed))
            }
        }
        
        // at this point the array should be full so we can go ahead and send it back...
        return returnArray
    }
}
