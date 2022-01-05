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
            self?.selectedImageView.image = photo
        }).disposed(by: disposeBag)
    }
}

