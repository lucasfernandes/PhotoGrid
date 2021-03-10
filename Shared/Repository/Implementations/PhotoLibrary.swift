//
//  PhotoLibraryService.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 01/03/21.
//

import UIKit
import Photos

class PhotoLibrary: NSObject, PhotoLibraryProtocol {
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
        
        if UIDevice.current.isSimulator {
            completionHandler(.success(true))
        } else {
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
    }
    
    func emptyAssetsArray() -> [PHAsset] {
        return [PHAsset]()
    }
    
    func saveImageToLibrary(image: UIImage, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        } completionHandler: { (_, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.success(image))
        }
    }
    
//    func saveImageToLibrary(image: UIImage) {
//        if !UIDevice.current.isSimulator {
//            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveCallBack), nil)
//        } else {
//            self.addNotificationForSavedImage(image: image, error: nil)
//        }
//    }
//
//    @objc func saveCallBack(_ image: UIImage,
//                            didFinishSavingWithError error: Error?,
//                            contextInfo: UnsafeRawPointer) {
//
//        self.addNotificationForSavedImage(image: image, error: error)
//    }
//
//    func addNotificationForSavedImage(image: UIImage, error: Error?) {
//        let userInfo: [String: Any] = ["image": image, "error": error as Any]
//        NotificationCenter.default.post(
//            name: Notification.Name("ImageSaved"),
//            object: nil,
//            userInfo: userInfo
//        )
//    }
}
