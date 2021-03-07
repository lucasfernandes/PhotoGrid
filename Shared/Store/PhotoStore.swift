//
//  PhotoStore.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 25/02/21.
//

import SwiftUI
import Photos

class PhotoStore: ObservableObject {
    let photoLibrary: PhotoLibraryProtocol
    
    @Published var photos = [Photo]()
    @Published var message: Message?
    @Published var selectedPhoto: Photo?
    
    var allAssets: PHFetchResult<PHAsset>!
    var localImageIdentifiers = [String]()
    var lastSavedImage: UIImage?
    var lastIdentifier: String?
    
    init(photoLibrary: PhotoLibraryProtocol) {
        self.photoLibrary = photoLibrary
        self.getAllPhotos()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onAfterSaveImageToLibrary(_:)),
            name: Notification.Name("ImageSaved"),
            object: nil)
    }
}

extension PhotoStore {
    func getAllPhotos() {
        self.getImageIdentifiersFromUserDefaults()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: true)]
            
            self.photoLibrary.fetchAssets(identifiers: self.localImageIdentifiers) { assets in
                self.allAssets = assets
            }

            var imagesToRequest = self.photoLibrary.emptyAssetsArray()
            guard let results = self.allAssets, results.count > 0 else { return }
            
            results.enumerateObjects { object, _, _ in
                if self.localImageIdentifiers.contains(object.localIdentifier) {
                    imagesToRequest.append(object)
                }
            }
            
            for asset in imagesToRequest {
                self.photoLibrary.requestImage(asset: asset) { image in
                    self.photos.append(self.makePhoto(identifier: asset.localIdentifier, image: image))
                }
            }
        }
    }
    
    func saveImage(image: UIImage, identifier: String?) {
        if let identifier = identifier {
            self.lastIdentifier = identifier
        }
        
        self.photoLibrary.saveImageToLibrary(image: image)
    }
    
    func getLatestAssetFromLibrary() -> PHAsset {
        return self.photoLibrary.lastAssetFromLibrary()
    }
    
    func makePhoto(identifier: String, image: UIImage) -> Photo {
        return Photo(id: identifier, image: image)
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
        self.photoLibrary.deleteAsset(identifier: id) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self.message = Message.generate(type: .error, action: .deleted)
            case .success(let isSuccess):
                if isSuccess {
                    self.localImageIdentifiers.removeAll(where: { $0 == id })
                    UserDefaults.standard.set(self.localImageIdentifiers, forKey: "Images")
                    
                    DispatchQueue.main.async {
                        self.photos.removeAll(where: { $0.id == id })
                        self.message = Message.generate(type: .success, action: .deleted)
                    }
                }
            }
        }
    }
    
    @objc func onAfterSaveImageToLibrary(_ notification: Notification) {
        if notification.userInfo?["error"] as? Error != nil {
            self.message = Message.generate(type: .error, action: .added)
            return
        }

        if let image = notification.userInfo?["image"] as? UIImage {
            let identifier = UIDevice.current.isSimulator
                ? lastIdentifier
                : getLatestAssetFromLibrary().localIdentifier
            
            if self.localImageIdentifiers.contains(identifier!) {
                return
            }
            
            let photo = self.makePhoto(identifier: identifier!, image: image)
            self.saveImageIdentifierToUserDefaults(identifier: identifier!)
            self.message = Message.generate(type: .success, action: .added)
            
            DispatchQueue.main.async {
                self.photos.append(photo)
            }
        }
    }
}
