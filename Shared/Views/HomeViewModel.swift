//
//  HomeViewModel.swift
//  PhotoGrid
//
//  Created by Lucas Silveira on 27/02/21.
//

import SwiftUI
import Photos

extension HomeView {
    
    enum ActiveSheet: Identifiable {
        case first, second, third
        
        var id: Int {
            hashValue
        }
    }
    
    func dismissSheet() {
        loadImage()
    }
    
    func openPhoto(photo: Photo) {
        self.photoStore.selectedPhoto = photo
        self.activeSheet = .first
    }
    
    func deletePhoto(id: String) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
        
        self.photoIdentifierToDelete = id
        self.showingAlert = true
    }
    
    func loadImage() {
        guard let image = inputImage else { return }
        self.saveImage(image: image, identifier: inputIdentifier)
        inputImage = nil
        inputIdentifier = nil
    }
    
    func takePhoto() {
        self.requestPermissions()
        self.activeSheet = .second
    }
    
    func saveImage(image: UIImage, identifier: String?) {
        self.photoStore.saveImage(image: image, identifier: identifier)
    }
    
    func requestPermissions() {
        // Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                // access granted
            } else {
                DispatchQueue.main.async {
                    let alert = UIAlertController()
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }))
                }
            }
        }
        
        // Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized {
                    // access granted
                } else {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                    }
                }
            })
        }
    }
}
