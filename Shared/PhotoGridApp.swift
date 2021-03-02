//
//  PhotoGridApp.swift
//  Shared
//
//  Created by Lucas Silveira on 24/02/21.
//

import SwiftUI

@main
struct PhotoGridApp: App {
    var photoStore = PhotoStore(photoLibraryService: PhotoLibraryService())
//        var photoStore = PhotoStore()
    var favoriteStore = FavoriteStore()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(photoStore)
                .environmentObject(favoriteStore)
        }
    }
}
