//
//  CoreDataManager.swift
//  LetsEat
//
//  Created by kamilcal on 31.01.2023.
//

import CoreData

struct CoreDataManager{
    
    let conteiner: NSPersistentContainer
    init(){
        conteiner = NSPersistentContainer(name: "LetsEatModel")
        conteiner.loadPersistentStores { (storeDesc, error) in
            error.map {
                print($0)
            }
        }
    }
}

extension CoreDataManager{
    static var shared = CoreDataManager()

//    MARK: - add
    func addReview(_ reviewItem: ReviewItem){
        let review = Review(context: conteiner.viewContext)
        review.date = Date()
        if let reviewItemRating = reviewItem.rating{
            review.rating = reviewItemRating
        }
        review.title = reviewItem.title
        review.name = reviewItem.name
        review.customerReview = reviewItem.customerReview
        if let reviewItemRestID = reviewItem.restaurantID{
            review.restaurantID = reviewItemRestID
        }
        review.uuid = reviewItem.uuid
        save()
    }
    
    func addPhoto(_ restPhotoItem: RestaurantPhotoItem){
        let restPhoto = RestaurantPhoto(context: conteiner.viewContext)
        restPhoto.date = Date()
        restPhoto.photo = restPhotoItem.photoData
        if let restPhotoID = restPhotoItem.restaurantID{
            restPhoto.restaurantID = restPhotoID
        }
        restPhoto.uuid = restPhotoItem.uuid
        save()
    }
    
//    MARK: - fetch
    
    func fetchReviews(by identifier: Int) -> [ReviewItem] {
        let moc = conteiner.viewContext
        let request = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", identifier)
        var reviewItems: [ReviewItem] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        do {
            for review in try moc.fetch(request){
                reviewItems.append(ReviewItem(review: review))
            }
            return reviewItems
        } catch{
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    func fetchRestPhotos(by identifier: Int) -> [RestaurantPhotoItem] {
        let moc = conteiner.viewContext
        let request = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", identifier)
        var restPhotoItems: [RestaurantPhotoItem] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        do {
            for restPhoto in try moc.fetch(request){
                restPhotoItems.append(RestaurantPhotoItem(restaurantPhoto: restPhoto))
            }
            return restPhotoItems
        } catch{
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
//    MARK: - save
    private func save(){
        do {
            if conteiner.viewContext.hasChanges{
                try conteiner.viewContext.save()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
