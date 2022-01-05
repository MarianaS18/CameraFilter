//
//  FilterService.swift
//  CameraFilter
//
//  Created by Mariana Steblii on 05/01/2022.
//

import UIKit
import CoreImage
import RxSwift

class FilterService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    // take the image...applying the filter to the image...returning the image
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
    
    // apply the filter with rxSwift
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilter(to: inputImage) {filteredImage in
                observer.onNext(filteredImage)
            }
            return Disposables.create()
        }
    }
}
