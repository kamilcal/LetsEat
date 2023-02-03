//
//  PhotosViewController.swift
//  LetsEat
//
//  Created by kamilcal on 2.02.2023.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var photosCollectionView: UICollectionView!
    
    var restaurantPhotos: [RestaurantPhotoItem] = []
    var selectedRestaurantID:Int?
    
    
//MARK: - Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPhotos()
    }
}
//MARK: - setup

private extension PhotosViewController{
    func initialize(){
        setupCV()
    }
    
    func setupCV(){
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        photosCollectionView.collectionViewLayout = flow
    }
    
    func checkPhotos(){
        let viewController = self.parent as? RestaurantDetailTableViewController
        if let restaurantID = viewController?.selectedRestaurant?.restaurantID{
            restaurantPhotos = CoreDataManager.shared.fetchRestPhotos(by: restaurantID)
            if !restaurantPhotos.isEmpty {
                photosCollectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: photosCollectionView.frame.width,
                                                    height: photosCollectionView.frame.height))
                view.set(title: "Photos",
                         desc: "There are currently no photos")
                photosCollectionView.backgroundView = view
            }
        }
        photosCollectionView.reloadData()
    }
}
//MARK: - Delegate - DataSource Methods

extension PhotosViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        restaurantPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotosCell
        let item = restaurantPhotos[indexPath.item]
        
        if let photo = item.photo {
            cell.set(image: photo )
        }
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        if restaurantPhotos.count == 1 {
            let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        } else {
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
}
