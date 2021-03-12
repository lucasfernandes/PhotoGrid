//
//  FavoritesView.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 26/02/21.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var favoriteStore: FavoriteStore
    @State var activeSheet = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(favoriteStore.favorites) { favorite in
                    Button(action: {
                        photoStore.selectedPhoto = favorite
                        activeSheet = true
                    }) {
                        ZStack {
                            Color.pink
                                .frame(width: 80, height: 80, alignment: .center)
                                .clipShape(Circle())
                            
                            Color.white
                                .frame(width: 75, height: 75, alignment: .center)
                                .clipShape(Circle())
                            Image(uiImage: favorite.image)
                                .frame(width: 70, height: 70, alignment: .center)
                                .clipShape(Circle())
                        }
                    }
                }
            }.padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                favoriteStore.loadFavorites(photos: photoStore.photos)
            }
        }
        
        .fullScreenCover(isPresented: $activeSheet, content: {
            DetailPhotoView(showHeart: false)
        })
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
