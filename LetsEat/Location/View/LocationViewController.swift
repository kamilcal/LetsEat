//
//  LocationViewController.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    let manager = LocationDataManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch()
    }
    

}

extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfLocationItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = manager.locationItem(at: indexPath.row)
        return cell
    }
    
    
    
}
