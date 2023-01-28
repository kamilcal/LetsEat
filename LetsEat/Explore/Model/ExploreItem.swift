//
//  ExploreItem.swift
//  LetsEat
//
//  Created by kamilcal on 25.12.2022.
//

import Foundation

struct ExploreItem: Equatable {
    
    let name: String?
    let image: String?
}

extension ExploreItem {
    
    init(dict: [String: String]) {
        
        self.name = dict["name"]
        self.image = dict["image"]
    }
}
