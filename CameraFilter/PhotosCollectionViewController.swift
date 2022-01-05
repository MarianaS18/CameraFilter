//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by Mariana Steblii on 05/01/2022.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        // ask user's permission to acces photolibrary
        // we use weak self, because it is an assyncrounus operation. So we are sure that it not will be ratain cykcle
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                // acces the photos from photolibrary
                let assests = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assests.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                // we make sure that images are in reverse order, so the most resent images are on the top
                self?.images.reverse()
                print(self?.images)
            }
        }
    }
}
