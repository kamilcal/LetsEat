//
//  ReviewItem.swift
//  LetsEat
//
//  Created by kamilcal on 31.01.2023.
//

import UIKit

struct ReviewItem{
    var restaurantID: Int64?
    var rating: Double?
    var customerReview: String?
    var name: String?
    var title: String?
    var date: Date?
    var uuid = UUID()
}

extension ReviewItem {
    init(review: Review){
        self.restaurantID = review.restaurantID
        self.rating = review.rating
        self.customerReview = review.customerReview
        self.name = review.name
        self.title = review.title
        self.date = review.date
        if let reviewUUID = review.uuid{
            self.uuid = reviewUUID
        }
    }
    
}
