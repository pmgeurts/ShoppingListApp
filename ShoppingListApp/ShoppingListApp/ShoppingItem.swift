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
    var price: Int
    init(name: String, price: Int = 0) {
        self.name = name
        self.price = price
    }
}
