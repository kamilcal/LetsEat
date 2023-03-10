//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by kamilcal on 1.02.2023.
//

import UIKit

class ReviewsViewController: UIViewController {
    
    
    @IBOutlet var reviewscollectionView: UICollectionView!
    
    var selectedRestaurantID: Int?
    private var reviewItems: [ReviewItem] = []
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter
    }()
    
//MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkReviews()
    }
    
}
//MARK: - setup

extension ReviewsViewController{
    
    func initialize(){
        setupCollectionView()
    }
    
    func setupCollectionView(){
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        reviewscollectionView.collectionViewLayout = flow
    }
    
    func checkReviews(){
        let viewController = self.parent as? RestaurantDetailTableViewController
        if let restaurantID = viewController?.selectedRestaurant?.restaurantID{
            reviewItems = CoreDataManager.shared.fetchReviews(by: restaurantID)
            if !reviewItems.isEmpty {
                reviewscollectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: reviewscollectionView.frame.width,
                                                    height: reviewscollectionView.frame.height))
                view.set(title: "Reviews",
                         desc: "There are currently no reviews")
                reviewscollectionView.backgroundView = view
            }
        }
        reviewscollectionView.reloadData()
    }
}
//MARK: - Delegate - DataSource Methods

extension ReviewsViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let reviewItem = reviewItems[indexPath.item]
        cell.nameLabel.text = reviewItem.name
        cell.titleLabel.text = reviewItem.title
        cell.reviewLabel.text = reviewItem.customerReview
        if let reviewItemRating = reviewItem.rating{
            cell.ratingsView.rating = reviewItemRating
        }
        if let reviewDate = reviewItem.date{
            cell.dateLabel.text = dateFormatter.string(from: reviewDate)
        }
        return cell
    }
}

extension ReviewsViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let edgeInset = 7.0
        if reviewItems.count == 1{
            let cellWidth = collectionView.frame.width - (edgeInset * 2)
            return CGSize(width: cellWidth, height: 200)
        } else {
            let cellWidth = collectionView.frame.width - (edgeInset * 3)
            return CGSize(width: cellWidth, height: 200)
        }
    }
}
