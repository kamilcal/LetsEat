//
//  ExploreCell.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import UIKit

class ExploreCell: UICollectionViewCell {
    
    @IBOutlet var exploreNameLabel: UILabel!
    
    
    @IBOutlet var exploreImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configurePhotoView()
    }
    
    private func configurePhotoView(){
        exploreImageView.layer.cornerRadius = 10
        exploreImageView.layer.shadowRadius = 10
    }
    
    private func configureView(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}

