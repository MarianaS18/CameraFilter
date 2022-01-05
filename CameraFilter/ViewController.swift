//
//  ViewController.swift
//  CameraFilter
//
//  Created by Mariana Steblii on 05/01/2022.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var filterButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else {
                  fatalError("Segue destionation is not found")
              }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        selectedImageView.image = image
        filterButton.isHidden = false
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        guard let sourceImage = self.selectedImageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                DispatchQueue.main.async {
                    self.selectedImageView.image = filteredImage
                }
            }).disposed(by: disposeBag)
    }
}

