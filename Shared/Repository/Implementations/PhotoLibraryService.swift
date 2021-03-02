//
//  PhotoLibraryService.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 01/03/21.
//

import UIKit
import Photos

class PhotoLibraryService: NSObject, PHPPhotoLibraryFacade {
    var delegate: PHPPhotoLibraryFacadeSave?
    
    func fetchAssets(identifiers: [String], completionHandler: @escaping (PHFetchResult<PHAsset>) -> Void) {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                         ascending: true)]
        let assets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers,
                                             options: fetchOptions)
        
        completionHandler(assets)
    }
    
    func lastAssetFromLibrary() -> PHAsset {
        let fetchOptions = PHFetchOptions()
        let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        return allAssets.lastObject!
    }
    
    func requestImage(asset: PHAsset, completionHandler: @escaping (UIImage) -> Void) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        let targetSize = CGSize(width: 120, height: 120)
        
        PHImageManager.default().requestImage(for: asset,
                                              targetSize: targetSize,
                                              contentMode: .aspectFill,
                                              options: options,
                                              resultHandler: { image, _ in
            completionHandler(image!)
        })
    }
    
    func deleteAsset(identifier: String, completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        PHPhotoLibrary.shared().performChanges({
            let imageAssetToDelete = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
            PHAssetChangeRequest.deleteAssets(imageAssetToDelete)
        }, completionHandler: {success, error in
            if error != nil {
                completionHandler(.failure(error!))
            } else {
                completionHandler(.success(success))
            }
        })
    }
    
    func emptyAssetsArray() -> [PHAsset] {
        return [PHAsset]()
    }
    
    func saveImageToLibrary(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveCallBack), nil)
    }
    
    @objc func saveCallBack(_ image: UIImage,
                            didFinishSavingWithError error: Error?,
                            contextInfo: UnsafeRawPointer) {
        
        self.delegate?.onAfterSaveImageToLibrary(image: image, error: error)
    }
}
