//
//  ImageFiltering.swift
//  LetsEat
//
//  Created by kamilcal on 30.01.2023.
//

import UIKit
import CoreImage
protocol ImageFiltering {
    func apply(filter: String, originalImage: UIImage) -> UIImage
}
extension ImageFiltering {
    func apply(filter: String, originalImage: UIImage) -> UIImage {
        let initialCIImage = CIImage(image: originalImage, options: nil)
        let originalOrientation = originalImage.imageOrientation
        guard let ciFilter = CIFilter(name: filter) else {
            print("filter not found")
            return originalImage
        }
        ciFilter.setValue(initialCIImage, forKey: kCIInputImageKey)
        let context = CIContext()
        let filteredCIImage = (ciFilter.outputImage)!
        //        Üstteki ifadeler, seçilen filtreyi firstCIImage'a uygular ve sonucu filteredCIImage'da depolar.
        let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent)
        return UIImage(cgImage: filteredCGImage!, scale: 1.0, orientation: originalOrientation)
        //        Bu ifadeler, filteredCIImage içinde depolanan CIImage örneğini tekrar bir UIImage örneğine dönüştürür ve onu döndürür.

    }
}
