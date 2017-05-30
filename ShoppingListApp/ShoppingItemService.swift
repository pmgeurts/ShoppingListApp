//
//  ShoppingItemService.swift
//  MyFirstTableViewProject
//
//  Created by Ben Smith on 09/02/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation

class ShoppingItemService {
    
    class func getTheDataFromShoppingService() -> [ShoppingItem] {
        var shoppingItemArray: [ShoppingItem] = []
        //(1)This line gets the Json Dictionary using our service data class function returning an NSDictionary
        let JSONDictionary = getData() as NSDictionary
        
        //(2)Create an variable arrayOfDictionaries and assign it JSONDictionary
        //   Use the Key "ShoppingItems" in JSONDictionary
        //   cast it to an array:    as! NSArray
        let arrayOfDictionaries = JSONDictionary[JSONKeys.shoppingitem] as! NSArray
        
        
        //(3)Iterate the arrayOfDictionaries
        
        for shoppingItemDictionary in arrayOfDictionaries {
            //(4)Create a variable, assign it the value of shoppingItemDictionary
            //   Cast this using: shoppingItemDictionary as! NSDictionary
            let shoppingItem = shoppingItemDictionary as! NSDictionary
            
            
            //(5)Create a variable for name of item
            //   Assign the variable the value of the key: shoppingItem[“name”] as! String
            let nameOfItem = shoppingItem[JSONKeys.name] as! String
            
            //(6)Create a variable for price of item
            //   Assign it the value of the key “price”: shoppingItem[“price”] as! Int
            let priceOfItem = shoppingItem[JSONKeys.price] as! Int
            
            //(7)Create a variable shopItem, assign it the instance of ShoppingItem
            //   var shopItem = ShoppingItem.init… let it autocomplete
            let currentShopItem = ShoppingItem.init(name: nameOfItem, price: priceOfItem)
            
            //(8)Append shoppingItemArray with the variable shopItem
            shoppingItemArray.append(currentShopItem)
        }
        
        //(9)This is an array of shoppingItems
        return shoppingItemArray
    }
    
    class func getData() -> NSDictionary {
        //Here is the escaped string...just imagine this is our data retrieved from a server! Like for real!!!
        let itemsJSONString = "{\r\n    \"ShoppingItems\": [\r\n        {\r\n        \"name\": \"Coffee\",\r\n        \"price\": 5.50\r\n        },\r\n        {\r\n        \"name\": \"Milk\",\r\n        \"price\": 1\r\n        },\r\n        {\r\n        \"name\": \"Sugar\",\r\n        \"price\": 1.2\r\n        },\r\n        {\r\n        \"name\": \"Lemons\",\r\n        \"price\": 0.5\r\n        },\r\n        {\r\n        \"name\": \"Turnips\",\r\n        \"price\": 0.5\r\n        },\r\n        {\r\n        \"name\": \"Carrots\",\r\n        \"price\": 2\r\n        },\r\n        {\r\n        \"name\": \"Shampoo\",\r\n        \"price\": 5\r\n        },\r\n        {\r\n        \"name\": \"Chicken\",\r\n        \"price\": 1.5\r\n        },\r\n        {\r\n        \"name\": \"Meditation Mat\",\r\n        \"price\": 10\r\n        },\r\n        {\r\n        \"name\": \"Cream\",\r\n        \"price\": 2\r\n        },\r\n        {\r\n        \"name\": \"Frogs Legs\",\r\n        \"price\": 14.5\r\n        },\r\n        {\r\n        \"name\": \"Bitter Ballen\",\r\n        \"price\": 3.5\r\n        },\r\n        {\r\n        \"name\": \"Beard Trimmer\",\r\n        \"price\": 14\r\n        }\r\n    ]\r\n}\r\n"
        
        return itemsJSONString.parseJSONString as! NSDictionary
    }
}





