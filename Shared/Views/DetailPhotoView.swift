//
//  SheetView.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 26/02/21.
//

import SwiftUI

struct DetailPhotoView: View {
    var showHeart: Bool? = true
    
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var favoriteStore: FavoriteStore
    @Environment(\.presentationMode) var presentationMode
    @State private var favIcon = "heart"
    
    @Environment(\.colorScheme) var colorScheme
    
    func toogleIcon() {
        let photo = $photoStore.selectedPhoto.wrappedValue!
        favIcon = photo.favorite
            ? "heart.fill"
            : "heart"
    }
    
    func toogleFavorite() {
        photoStore.selectedPhoto?.favorite.toggle()
        favoriteStore.save(photo: photoStore.selectedPhoto!)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image(uiImage: $photoStore.selectedPhoto.wrappedValue!.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 20)
                    .accessibility(identifier: "close")
                }
                
                if showHeart! {
                    VStack {
                        Button(action: {
                            self.toogleFavorite()
                            self.toogleIcon()
                        }) {
                            Image(systemName: favIcon)
                                .font(.title)
                                .foregroundColor(.pink)
                        }
                        .padding()
                        .accessibility(identifier: "favorite")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(colorScheme == .dark ? .tertiarySystemBackground : .black))
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear(perform: toogleIcon)
    }
}

struct DetailPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPhotoView()
    }
}
