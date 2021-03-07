//
//  PHAsset+withImageRequest.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 27/02/21.
//

import UIKit
import Photos

extension PHAsset {
    var image: UIImage { 
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        
        imageManager.requestImage(
            for: self,
            targetSize: CGSize(width: 120, height: 120),
            contentMode: .aspectFit,
            options: nil,
            resultHandler: { image, _ in
                thumbnail = image!
        })
        return thumbnail
    }
}
