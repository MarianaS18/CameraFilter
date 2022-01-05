//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by Mariana Steblii on 05/01/2022.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                // acces the photos from photolibrary
            }
        }
    }
}
