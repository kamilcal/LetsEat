//
//  RestaurantDetailTableViewController.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import UIKit

class RestaurantDetailTableViewController: UITableViewController {

    var selectedRestaurant: RestaurantItem?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)
       
    }

}
