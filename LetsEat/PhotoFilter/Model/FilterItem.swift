//
//  FilterItem.swift
//  LetsEat
//
//  Created by kamilcal on 30.01.2023.
//

import Foundation

struct FilterItem {
    let filter: String?
    let name: String?
    init(dict: [String: String]) {
        self.filter = dict["filter"]
        self.name = dict["name"]
    }
}

