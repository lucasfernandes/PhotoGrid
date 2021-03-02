//
//  PhotoStore.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 25/02/21.
//

import UIKit
import Photos

class PhotoStore: ObservableObject {
    let photoLibraryService: PhotoLibraryService
    
    @Published var photos = [Photo]()
    @Published var message: Message?
    @Published var selectedPhoto: Photo?
    
    var allAssets: PHFetchResult<PHAsset>!
    var localImageIdentifiers = [String]()
    var lastSavedImage: UIImage?
    
    init(photoLibraryService: PhotoLibraryService) {
        self.photoLibraryService = photoLibraryService
        self.photoLibraryService.delegate = self
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
            
            self.photoLibraryService.fetchAssets(identifiers: self.localImageIdentifiers) { assets in
                self.allAssets = assets
            }

            var imagesToRequest = self.photoLibraryService.emptyAssetsArray()
            guard let results = self.allAssets, results.count > 0 else { return }
            
            results.enumerateObjects { object, index, stop in
                if self.localImageIdentifiers.contains(object.localIdentifier) {
                    imagesToRequest.append(object)
                }
            }
            
            for asset in imagesToRequest {
                self.photoLibraryService.requestImage(asset: asset) { image in
                    self.photos.append(self.makePhoto(asset: asset, image: image))
                }
            }
        }
    }
    
    func saveImage(image: UIImage) {
        self.photoLibraryService.saveImageToLibrary(image: image)
    }
    
    func getLatestAssetFromLibrary() -> PHAsset {
        return self.photoLibraryService.lastAssetFromLibrary()
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
        self.photoLibraryService.deleteAsset(identifier: id) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.message = Message.generate(type: .error, action: .delete)
            case .success(let isSuccess):
                if isSuccess {
                    self.localImageIdentifiers.removeAll(where: { $0 == id })
                    UserDefaults.standard.set(self.localImageIdentifiers, forKey: "Images")
                    
                    DispatchQueue.main.async {
                        self.photos.removeAll(where: { $0.id == id })
                        self.message = Message.generate(type: .success, action: .delete)
                    }
                }
            }
        }
    }
}

extension PhotoStore: PHPPhotoLibraryFacadeSave {
    func onAfterSaveImageToLibrary(image: UIImage?, error: Error?) {
        if error != nil {
            self.message = Message.generate(type: .error, action: .add)
            return
        }
        
        let lastAssetFromLibrary = getLatestAssetFromLibrary()
        let photo = self.makePhoto(asset: lastAssetFromLibrary, image: image!)
        self.saveImageIdentifierToUserDefaults(identifier: lastAssetFromLibrary.localIdentifier)
        self.message = Message.generate(type: .success, action: .add)
        
        DispatchQueue.main.async {
            self.photos.append(photo)
        }
        
        // TODO: callback after save to show success message
    }
}
