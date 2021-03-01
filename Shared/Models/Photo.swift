//
//  Photo.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 24/02/21.
//

import SwiftUI

class Photo: ObservableObject, Identifiable {    
    var id: String
    var image: UIImage
    @Published var favorite: Bool = false
    
    init(id: String, image: UIImage) {
        self.id = id
        self.image = image
    }
}

extension Photo {
    static func previewPhotosGenerate() -> [Photo] {
        var photos = [Photo]()
        for item in 1...7 {
            photos.append(Photo(id: UUID().description, image: UIImage(imageLiteralResourceName: item.description)))
        }
        
        return photos
    }
}
