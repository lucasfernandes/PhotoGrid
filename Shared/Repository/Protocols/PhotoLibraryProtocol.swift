//
//  PHPPhotoLibraryFacade.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 01/03/21.
//

import UIKit
import Photos

//sourcery: AutoMockable
protocol PhotoLibraryProtocol: NSObject {
    func fetchAssets(identifiers: [String], completionHandler: @escaping (PHFetchResult<PHAsset>) -> Void)
    func lastAssetFromLibrary() -> PHAsset
    func requestImage(asset: PHAsset, completionHandler: @escaping (UIImage) -> Void)
    func deleteAsset(identifier: String, completionHandler: @escaping (Result<Bool, Error>) -> Void)
    func emptyAssetsArray() -> [PHAsset]
    func saveImageToLibrary(image: UIImage, completionHandler: @escaping (Result<UIImage, Error>) -> Void)
}
