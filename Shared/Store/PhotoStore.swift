//
//  PhotoStore.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 25/02/21.
//

import UIKit
import Photos

class PhotoStore: NSObject, ObservableObject {
    @Published var photos = [Photo]()
    @Published var message: Message?
    @Published var selectedPhoto: Photo?
    
    var allAssets: PHFetchResult<PHAsset>!
    var localImageIdentifiers = [String]()
    var lastSavedImage: UIImage?
    
    override init() {
        super.init()
        self.getAllPhotos()
    }
}

extension PhotoStore {
    func getAllPhotos() {
        self.getImageIdentifiersFromUserDefaults()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: true)]
            
            self.allAssets = PHAsset.fetchAssets(withLocalIdentifiers: self.localImageIdentifiers,
                                                 options: fetchOptions)
            
            var imagesToRequest = [PHAsset]()
            guard let results = self.allAssets, results.count > 0 else { return }
            
            results.enumerateObjects { object, index, stop in
                if self.localImageIdentifiers.contains(object.localIdentifier) {
                    imagesToRequest.append(object)
                }
            }
            
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            options.deliveryMode = .highQualityFormat
            let targetSize = CGSize(width: 120, height: 120)
            
            for asset in imagesToRequest {
                PHImageManager.default().requestImage(for: asset,
                                                      targetSize: targetSize,
                                                      contentMode: .aspectFill,
                                                      options: options,
                                                      resultHandler: { image, _ in
                    self.photos.append(self.makePhoto(asset: asset, image: image!))
                })
            }
        }
    }
    
    func saveImage(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCallBack), nil)
    }
    
    @objc func saveCallBack(_ image: UIImage,
                            didFinishSavingWithError error: Error?,
                            contextInfo: UnsafeRawPointer) {
        if error != nil  {
            self.message = Message.generate(type: .error, action: .add)
            return
        } else {
        
            let lastAssetFromLibrary = getLatestAssetFromLibrary()
            let photo = self.makePhoto(asset: lastAssetFromLibrary, image: image)
            self.saveImageIdentifierToUserDefaults(identifier: lastAssetFromLibrary.localIdentifier)
            self.message = Message.generate(type: .success, action: .add)
            
            DispatchQueue.main.async {
                self.photos.append(photo)
            }
            
            // TODO: callback after save to show success message
        }
    }
    
    func getLatestAssetFromLibrary() -> PHAsset {
        let fetchOptions = PHFetchOptions()
        let allAssets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        return allAssets.lastObject!
    }
    
    func makePhoto(asset: PHAsset, image: UIImage) -> Photo {
        let id = asset.localIdentifier
        return Photo(id: id, image: image)
    }
    
    func saveImageIdentifierToUserDefaults(identifier: String) {
        self.localImageIdentifiers.append(identifier)
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Images")
        defaults.set(self.localImageIdentifiers, forKey: "Images")
    }
    
    func getImageIdentifiersFromUserDefaults() {
        self.localImageIdentifiers = UserDefaults.standard
            .object(forKey: "Images") as? [String] ?? [String]()
    }
    
    func deletePhoto(id: String) {
        PHPhotoLibrary.shared().performChanges({
            let imageAssetToDelete = PHAsset.fetchAssets(withLocalIdentifiers: [id], options: nil)
            PHAssetChangeRequest.deleteAssets(imageAssetToDelete)
        }, completionHandler: {success, error in
            if error != nil {
                self.message = Message.generate(type: .error, action: .delete)
                return
            } else {
            
                self.localImageIdentifiers.removeAll(where: { $0 == id })
                UserDefaults.standard.set(self.localImageIdentifiers, forKey: "Images")
                
                DispatchQueue.main.async {
                    self.photos.removeAll(where: { $0.id == id })
                    self.message = Message.generate(type: .success, action: .delete)
                }
                // TODO: callback after deletePhoto to show delete message
            }
        })
    }
}
