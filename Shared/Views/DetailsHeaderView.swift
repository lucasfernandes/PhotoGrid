//
//  DetailsHeaderView.swift
//  PhotoGrid (iOS)
//
//  Created by Lucas Silveira on 27/02/21.
//

import SwiftUI

struct DetailsHeaderView: View {
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var favoriteStore: FavoriteStore
    
    var body: some View {
        HStack(spacing: 20) {
            VStack {
                Text("\($photoStore.photos.wrappedValue.count)")
                    .fontWeight(.bold)
                Text("Photos")
                    .font(.callout)
            }
            
            VStack {
                Text("\($favoriteStore.favorites.wrappedValue.count)")
                    .fontWeight(.bold)
                Text("Favorites")
                    .font(.callout)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 20)
    }
}

struct DetailsHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsHeaderView()
    }
}
