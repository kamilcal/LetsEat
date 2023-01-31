//
//  RestaurantPhotoItem.swift
//  LetsEat
//
//  Created by kamilcal on 31.01.2023.
//

import UIKit


struct RestaurantPhotoItem {
    var restaurantID: Int64?
    var date: Date?
    var photo: UIImage?
    var photoData: Data{
        guard let photo = photo, let photoData = photo.pngData() else {
            return Data()
        }
        return photoData
    }
    var uuid = UUID()
}

extension RestaurantPhotoItem{
    init(restaurantPhoto: RestaurantPhoto){
        self.restaurantID = restaurantPhoto.restaurantID
        self.date = restaurantPhoto.date
        if let restPhoto = restaurantPhoto.photo{
            self.photo = UIImage(data: restPhoto, scale: 1.0)
        }
        if let restUuid = restaurantPhoto.uuid{
            self.uuid = restUuid
        }
    }
}
