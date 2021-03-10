//
//  PhotoGridTests.swift
//  PhotoGridTests
//
//  Created by Lucas Silveira on 01/03/21.
//

import XCTest
import Photos
import SwiftyMocky
@testable import PhotoGrid

class PhotoStoreTests: XCTestCase {
    
    var photoStore: PhotoStore!
    var photoLibrary: PhotoLibraryProtocolMock!
    
    override func setUp() {
        photoLibrary = PhotoLibraryProtocolMock()
        photoStore = PhotoStore(photoLibrary: photoLibrary)
    }

    func testMakePhoto() {
        let asset = PHAsset()
        let image = UIImage(imageLiteralResourceName: "1")
        
        let photo = Photo(id: UUID().description, image: image)
        let generatedPhoto = photoStore.makePhoto(identifier: asset.localIdentifier, image: image)
        
        XCTAssertEqual(photo.image, generatedPhoto.image)
    }
    
    func testSaveImageToLibrary() {
        let someImage = UIImage(imageLiteralResourceName: "1")
        
        Perform(photoLibrary, .saveImageToLibrary(
                    image: .any,
                    completionHandler: .any,
                    perform: { (image, completionHandler) in
                        completionHandler(.success(image))
                    }))
        
        photoStore.saveImage(image: someImage, identifier: "xyz")
        
        eventually {
            XCTAssertEqual(self.photoStore.photos.count, 1)
        }
    }
    
    func testWhenFailureToSaveImageToLibrary() {
        let someImage = UIImage(imageLiteralResourceName: "1")
        
        Perform(photoLibrary, .saveImageToLibrary(
                    image: .any,
                    completionHandler: .any,
                    perform: { (image, completionHandler) in
                        completionHandler(.failure(URLError(.unknown)))
                    }))
        
        photoStore.saveImage(image: someImage, identifier: "xyz")
        
        eventually {
            XCTAssertFalse(self.photoStore.photos.count == 1)
        }
    }
    
    func testDeletingImageFromLibrary() {
        let someImage = UIImage(imageLiteralResourceName: "2")
        let someIdentifier = "abc"
        
        Perform(photoLibrary, .saveImageToLibrary(
                    image: .any,
                    completionHandler: .any,
                    perform: { (image, completionHandler) in
                        completionHandler(.success(image))
                    }))
        
        photoStore.saveImage(image: someImage, identifier: someIdentifier)
        
        Perform(photoLibrary, .deleteAsset(
                    identifier: .any,
                    completionHandler: .any, perform: { (_, completionHandler) in
                        completionHandler(.success(true))
                    }))
        
        photoStore.deletePhoto(id: someIdentifier)
        
        eventually {
            XCTAssertEqual(self.photoStore.photos.count, 0)
        }
    }
    
    func testFailureToDeleteImageFromLibrary() {
        let someImage = UIImage(imageLiteralResourceName: "2")
        let someIdentifier = "abc"
        
        Perform(photoLibrary, .saveImageToLibrary(
                    image: .any,
                    completionHandler: .any,
                    perform: { (image, completionHandler) in
                        completionHandler(.success(image))
                    }))
        
        photoStore.saveImage(image: someImage, identifier: someIdentifier)
        
        Perform(photoLibrary, .deleteAsset(
                    identifier: .any,
                    completionHandler: .any, perform: { (_, completionHandler) in
                        completionHandler(.failure(URLError(.unknown)))
                    }))
        
        photoStore.deletePhoto(id: someIdentifier)
        
        eventually {
            XCTAssertFalse(self.photoStore.photos.count == 0)
        }
    }
    
    func testWhenGetLatestImageFromLibrary() {
        let phAsset = PHAsset()
        Given(photoLibrary, .lastAssetFromLibrary(willReturn: phAsset))
        
        XCTAssertEqual(photoStore.getLatestAssetFromLibrary(), phAsset)
    }
}

extension XCTestCase {

    /// Simple helper for asynchronous testing.
    /// Usage in XCTestCase method:
    ///   func testSomething() {
    ///       doAsyncThings()
    ///       eventually {
    ///           /* XCTAssert goes here... */
    ///       }
    ///   }
    /// Cloure won't execute until timeout is met. You need to pass in an
    /// timeout long enough for your asynchronous process to finish, if it's
    /// expected to take more than the default 0.01 second.
    ///
    /// - Parameters:
    ///   - timeout: amout of time in seconds to wait before executing the
    ///              closure.
    ///   - closure: a closure to execute when `timeout` seconds has passed
    func eventually(timeout: TimeInterval = 0.01, closure: @escaping () -> Void) {
        let expectation = self.expectation(description: "")
        expectation.fulfillAfter(timeout)
        self.waitForExpectations(timeout: 60) { _ in
            closure()
        }
    }
}

extension XCTestExpectation {

    /// Call `fulfill()` after some time.
    ///
    /// - Parameter time: amout of time after which `fulfill()` will be called.
    func fulfillAfter(_ time: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            self.fulfill()
        }
    }
}
