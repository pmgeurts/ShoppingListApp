//
//  ShoppingItem.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 29/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import Foundation

class ShoppingItem: NSObject {
    var name: String
    var price: String
    var detailDescription: String
    init(name: String, price: String, detailDescription: String) {
        self.name = name
        self.price = price
        self.detailDescription = detailDescription
    }
}
