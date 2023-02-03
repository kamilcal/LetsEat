//
//  RestaurantCell.swift
//  LetsEat
//
//  Created by kamilcal on 27.12.2022.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var cuisineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        configurePhotoView()
    }
    
    private func configurePhotoView(){
        restaurantImageView.layer.cornerRadius = 10
        restaurantImageView.layer.shadowRadius = 10
    }
    
    private func configureView(){
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
}
