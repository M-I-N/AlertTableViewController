//
//  Model.swift
//  AlertTableViewController
//
//  Created by Nayem on 2/15/19.
//  Copyright © 2019 BJIT Ltd. All rights reserved.
//

import Foundation

class Model {
    let name: String
    let id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    static func allModels() -> [Model] {
        let models = [Model(name: "Nayem", id: 1), Model(name: "Ashik", id: 2), Model(name: "Azad", id: 3), Model(name: "Alvi", id: 4), Model(name: "Hasib", id: 5)]
        return models
    }
}
