//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by kamilcal on 29.01.2023.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    var selectedRestaurantID: Int?

    @IBOutlet var ratingsView: RatingsView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var reviewTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ReviewFormViewController{
    
    @IBAction func onSaveTapped(_ sender: Any) {
        var reviewItem = ReviewItem()
        reviewItem.rating = ratingsView.rating
        reviewItem.title = titleTextField.text
        reviewItem.name = nameTextField.text
        reviewItem.customerReview = reviewTextView.text
        if let selRestID = selectedRestaurantID {
            reviewItem.restaurantID = Int64(selRestID)
        }
        CoreDataManager.shared.addReview(reviewItem)
        dismiss(animated: true, completion: nil)
    }
}
