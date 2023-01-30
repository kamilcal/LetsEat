//
//  FilterCell.swift
//  LetsEat
//
//  Created by kamilcal on 30.01.2023.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 9
        imageView.layer.masksToBounds = true
    }
}
extension FilterCell: ImageFiltering {
    func set(filterItem: FilterItem, imageForThumbnail: UIImage) {
        titleLabel.text = filterItem.name
        if let filter = filterItem.filter {
            if filter != "None" {
                let filteredImage = apply(filter: filter, originalImage: imageForThumbnail)
                imageView.image = filteredImage
            } else {
                imageView.image = imageForThumbnail
            }
        }
    }
}
