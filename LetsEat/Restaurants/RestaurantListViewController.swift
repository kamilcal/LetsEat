//
//  RestaurantListViewController.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import UIKit

class RestaurantListViewController: UIViewController, UICollectionViewDelegate {
    
    
   
    @IBOutlet var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

     }
    
    
}

//MARK: - Private Extension

private extension RestaurantListViewController {
    
}

//MARK: - UICollectionViewDataSource

extension RestaurantListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }


}
