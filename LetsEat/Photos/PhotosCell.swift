//
//  PhotosCell.swift
//  LetsEat
//
//  Created by kamilcal on 2.02.2023.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
}

    extension PhotosCell {
        func set(image:UIImage) {
            imageView.image = image
        }
        override func awakeFromNib() {
            super.awakeFromNib()
            imageView.layer.cornerRadius = 9
            imageView.layer.masksToBounds = true
        }
    }
