//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by kamilcal on 24.12.2022.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate {
   
    
    @IBOutlet var collectionView: UICollectionView!
    let manager = ExploreDataManager()
    var selectedCity: LocationItem?
    var headerView: ExploreHeaderView!
 
    //MARK: - Lifecycle Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    //MARK: - Action

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.locationList.rawValue :
            showLocationList(segue: segue)
        case Segue.restaurantList.rawValue :
            showRestaurantList(segue: segue)
        default :
            print("segue not added")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Segue.restaurantList.rawValue,
           selectedCity == nil {
            showLocationRequiredAlert()
            return false
        }
        return true
    }
}

//MARK: - setupUI

private extension ExploreViewController{
    func initialize() {
        manager.fetch()
        
    }
    
    func showLocationList(segue: UIStoryboardSegue){
        guard let navController = segue.destination as? UINavigationController,
              let viewController = navController.topViewController as? LocationViewController else {
            return
            
        }
        viewController.selectedCity = selectedCity
        
    }
    
    func showRestaurantList(segue: UIStoryboardSegue) {
        if let viewcontroller = segue.destination as? RestaurantListViewController,
           let city = selectedCity,
           let index = collectionView.indexPathsForSelectedItems?.first?.row {
            viewcontroller.selectedCuisine = manager.exploreItem(at: index).name
            viewcontroller.selectedCity = city
        }
    }
    func showLocationRequiredAlert(){
        let alertController = UIAlertController(title: "Location Needed",
                                                message: "Please select a location.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: .default))
        present(alertController, animated: true)
        
    }
    
     @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {
         
     }
   
    @IBAction func unwindLocationDone(segue: UIStoryboardSegue){
        if let viewController = segue.source as? LocationViewController {
            selectedCity = viewController.selectedCity
            if let location = selectedCity {
                headerView.locationLabel.text = location.cityAndState
            }
        }
    }
}

//MARK: - Delegate - DataSource Methods

extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        manager.numberOfExploreItems()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let exploreItem = manager.exploreItem(at: indexPath.row)
        cell.exploreNameLabel.text = exploreItem.name
        cell.exploreImageView.image = UIImage(named: exploreItem.image!)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
        headerView = header as? ExploreHeaderView
        return headerView
    }
    
    

}
