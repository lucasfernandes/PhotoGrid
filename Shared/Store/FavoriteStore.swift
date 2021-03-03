//
//  FavoriteStore.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 27/02/21.
//

import UIKit
import Photos

class FavoriteStore: ObservableObject {
    @Published var favorites = [Photo]()
    
    private var favoriteIdentifiers = [String]()
    private var defaults = UserDefaults.standard
}

extension FavoriteStore {
    func save(photo: Photo) {
        self.defaults.removeObject(forKey: "Favorites")
        
        photo.favorite
            ? favoriteIdentifiers.append(photo.id)
            : favoriteIdentifiers.removeAll(where: { $0 == photo.id })
        
        self.saveToDefaults()
        self.manageFavorites(photo: photo)
    }
    
    func saveToDefaults() {
        self.defaults.set(self.favoriteIdentifiers, forKey: "Favorites")
    }
    
    func manageFavorites(photo: Photo) {
        photo.favorite
            ? favorites.append(photo)
            : favorites.removeAll(where: { $0.id == photo.id })
    }
    
    func getFavoriteIdentifiers() {
        self.favoriteIdentifiers = self.defaults
            .object(forKey: "Favorites") as? [String] ?? [String]()
    }
    
    func loadFavorites(photos: [Photo]) {
        self.getFavoriteIdentifiers()
        
        self.favorites = photos.filter { self.favoriteIdentifiers.contains($0.id) }
        
        for item in favorites {
            item.favorite.toggle()
        }
    }
    
    func delete(id: String) {
        self.favoriteIdentifiers.removeAll(where: {$0 == id})
        self.favorites.removeAll(where: {$0.id == id})
        self.saveToDefaults()
    }
}
