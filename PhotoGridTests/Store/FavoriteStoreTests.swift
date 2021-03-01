//
//  FavoriteStoreTests.swift
//  PhotoGridTests
//
//  Created by Lucas Silveira on 01/03/21.
//

import XCTest
import Photos
@testable import PhotoGrid

class FavoriteStoreTests: XCTestCase {
    
    var favoriteStore: FavoriteStore!
    
    override func setUp() {
        favoriteStore = FavoriteStore()
    }
    
    func testSavingAFavorite() {
        let image = UIImage(imageLiteralResourceName: "1")
        let photo = Photo(id: UUID().description, image: image)
        photo.favorite = true
        
        favoriteStore.save(photo: photo)
        XCTAssertEqual(favoriteStore.favorites.count, 1)
        
        favoriteStore.save(photo: photo)
        XCTAssertEqual(favoriteStore.favorites.last?.id, photo.id)
    }

    func testLoadingFavorites() {
        let image = UIImage(imageLiteralResourceName: "1")
        let photo = Photo(id: UUID().description, image: image)
        photo.favorite = true
        
        favoriteStore.save(photo: photo)
        
        let image2 = UIImage(imageLiteralResourceName: "2")
        let photo2 = Photo(id: UUID().description, image: image2)
        photo2.favorite = true
        
        favoriteStore.save(photo: photo2)
        
        favoriteStore.loadFavorites(photos: [photo, photo2])
        
        XCTAssertTrue(favoriteStore.favorites.count == 2)
        XCTAssertEqual(favoriteStore.favorites.first?.id, photo.id)
        XCTAssertEqual(favoriteStore.favorites.last?.id, photo2.id)
    }
    
    func testDeleteFromFavorites() {
        let image = UIImage(imageLiteralResourceName: "1")
        let photo = Photo(id: UUID().description, image: image)
        photo.favorite = true
        
        favoriteStore.save(photo: photo)
        XCTAssertTrue(favoriteStore.favorites.count == 1)
        
        favoriteStore.delete(id: photo.id)
        XCTAssertTrue(favoriteStore.favorites.count == 0)
    }
    
    func testWhenToogleOffAPhotoAsFavorite() {
        let image = UIImage(imageLiteralResourceName: "1")
        let photo = Photo(id: UUID().description, image: image)
        photo.favorite = true
        
        favoriteStore.save(photo: photo)
        XCTAssertTrue(favoriteStore.favorites.count == 1)
        
        photo.favorite = false
        favoriteStore.save(photo: photo)
        
        XCTAssertTrue(favoriteStore.favorites.count == 0)
    }

}
