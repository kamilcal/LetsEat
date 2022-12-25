//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import Foundation

class ExploreDataManager: DataManager{
    
    private var exploreItems: [ExploreItem] = []
    
    func fetch() {
        for data in loadPlist(file: "ExploreData") {
            exploreItems.append(ExploreItem(dict: data as! [String : String]))
        }
    }
   
    
    func numberOfExploreItems() -> Int {
        exploreItems.count
    }
    
    func exploreItem(at index: Int) -> ExploreItem {
        exploreItems[index]
    }
}
