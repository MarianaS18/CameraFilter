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
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell not found")
        }
        
        let asset = images[indexPath.row]
        // help to get the image
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 120, height: 120), contentMode: .aspectFill, options: nil) { image, _ in
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
        }
        
        return cell
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
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}
