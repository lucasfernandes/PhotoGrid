//
//  PhotoStore.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 25/02/21.
//

import SwiftUI
import Photos

//sourcery: AutoMockable
protocol PhotoStoreProtocol: ObservableObject {
    func getAllPhotos()
    func saveImage(image: UIImage, identifier: String?)
    func getLatestAssetFromLibrary() -> PHAsset
    func makePhoto(identifier: String, image: UIImage) -> Photo
    func saveImageIdentifierToUserDefaults(identifier: String)
    func getImageIdentifiersFromUserDefaults()
    func deletePhoto(id: String)
}

class PhotoStore: PhotoStoreProtocol {
    
    let photoLibrary: PhotoLibraryProtocol
    
    @Published var photos = [Photo]()
    @Published var message: Message?
    @Published var selectedPhoto: Photo?
    
    var allAssets: PHFetchResult<PHAsset>!
    var localImageIdentifiers = [String]()
    
    init(photoLibrary: PhotoLibraryProtocol) {
        self.photoLibrary = photoLibrary
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
        self.photoLibrary.saveImageToLibrary(image: image) { result in
            switch result {
            case .failure:
                print("error")
            case .success(let image):
                let lastIdentifier = UIDevice.current.isSimulator && identifier != nil
                    ? identifier
                    : self.getLatestAssetFromLibrary().localIdentifier
                
                if self.localImageIdentifiers.contains(lastIdentifier ?? "") {
                    return
                }
                
                let photo = self.makePhoto(identifier: lastIdentifier!, image: image)
                self.saveImageIdentifierToUserDefaults(identifier: lastIdentifier!)
                DispatchQueue.main.async {
                    self.message = Message.generate(type: .success, action: .added)
                    self.photos.append(photo)
                }
            }
        }
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
}
