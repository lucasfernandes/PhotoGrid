//
//  HomeView.swift
//  Shared
//
//  Created by Lucas Silveira on 24/02/21.
//

import SwiftUI
import Photos

struct HomeView: View {
    @State var photoIdentifierToDelete: String?
    @State var showingAlert = false
    @State var activeSheet: ActiveSheet?
    
    // Image Picker
    @State var inputImage: UIImage?
    @State var inputIdentifier: String?
    
    @EnvironmentObject var photoStore: PhotoStore
    @EnvironmentObject var favoriteStore: FavoriteStore
    
    // Grid columns config
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 1),
        GridItem(.flexible(minimum: 40), spacing: 1),
        GridItem(.flexible(minimum: 40), spacing: 1),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if photoStore.photos.count > 0 {
                    DetailsHeaderView()
                        .environmentObject(photoStore)
                        .environmentObject(favoriteStore)
                    FavoritesView()
                        .environmentObject(photoStore)
                        .environmentObject(favoriteStore)
                }
                
                VStack {
                    LazyVGrid(columns: columns, spacing: 1) {
                        ForEach(photoStore.photos) { photo in
                            Rectangle()
                                .aspectRatio(1, contentMode: .fill)
                                .overlay(
                                    Image(uiImage: photo.image)
                                        .resizable()
                                        .scaledToFill()
                                        .background(Color(UIColor.systemBackground))
                                )
                                .clipped()
                                .background(Color(UIColor.systemBackground))
                                .onTapGesture {self.openPhoto(photo: photo)}
                                .onLongPressGesture {self.deletePhoto(id: photo.id)}
                                .accessibility(identifier: "photo\(photo.id)")
                        }
                    }
                    .accessibility(identifier: "grid")

                    if photoStore.photos.count == 0 {
                        VStack {
                            Text("Add a new photo to your PhotoGrid!")
                                .font(.headline)
                                .foregroundColor(.primary)
                                .accessibility(identifier: "zeroPhotosFound")
                        }
                        .frame(maxHeight: .infinity, alignment: .center)
                    }
                }
            }
            .navigationBarItems(
                leading: Text("PhotoGrid")
                    .font(.title)
                    .foregroundColor(.primary),
                trailing: Button(action: {
                    self.takePhoto()
                }) {
                    Image(systemName: "plus.square")
                        .font(.title2)
                        .foregroundColor(.primary)
                }.accessibility(identifier: "add"))
            .onAppear(perform: self.requestPermissions)
        }
        
        .fullScreenCover(item: $activeSheet, onDismiss: self.dismissSheet) { item in
            switch item {
            case .first:
                DetailPhotoView()
                    .environmentObject(photoStore)
                    .environmentObject(favoriteStore)
            case .second:
                ImagePicker(image: self.$inputImage, identifier: self.$inputIdentifier)
                    .edgesIgnoringSafeArea(.all)
            case .third:
                Text("x")
            }
        }.accessibility(identifier: "fullScreenCover")
        
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Delete photo?"),
                  message: Text("The photo will be delete from PhotoGrid and Photos"),
                  primaryButton: .destructive(Text("Delete")) {
                    self.photoStore.deletePhoto(id: $photoIdentifierToDelete.wrappedValue!)
                    self.favoriteStore.delete(id: $photoIdentifierToDelete.wrappedValue!)
                  },
                  secondaryButton: .cancel())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

