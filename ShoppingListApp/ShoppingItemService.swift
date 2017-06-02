//
//  ShoppingItemService.swift
//  MyFirstTableViewProject
//
//  Created by Ben Smith on 09/02/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import Foundation
import FirebaseDatabase


class ShoppingItemService {
    public static let sharedInstance = ShoppingItemService()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    
    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
    }
    
    var ref: DatabaseReference!
    
    public func getShoppingListData() {
        ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? NSDictionary {
                let shoppingtems = data[JSONKeys.shoppingitem] as! NSDictionary
                let shoppingModelsDataArray = ShoppingItems.modelsFromDictionaryOf(dictionaries: shoppingtems)
                let shoppingDataDict = [JSONKeys.shoppingitem: shoppingModelsDataArray]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "gotShoppingListData"), object: self , userInfo: shoppingDataDict)
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
        
        ref.child(JSONKeys.shoppingitem).observe(.childAdded, with: { (snapshot) -> Void in
            //Do Something
            if let data = snapshot.value as? NSDictionary {
                let shoppingtems = ShoppingItems.init(dictionary: data)
                let shoppingDataDict = [JSONKeys.shoppingitem: shoppingtems]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "addedShoppingListData"), object: self , userInfo: shoppingDataDict)
            }
            print("childAdded")
        })
        
        ref.child(JSONKeys.shoppingitem).observe(.childRemoved, with: { (snapshot) -> Void in
            //Do Something
            if let data = snapshot.value as? NSDictionary {
                let shoppingtems = ShoppingItems.init(dictionary: data)
                let shoppingDataDict = [JSONKeys.shoppingitem: shoppingtems]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "removedShoppingListData"), object: self , userInfo: shoppingDataDict)
                print("childRemoved")
            }
            
        })
    }
    
    public func addShopItem(shopItem: ShoppingItems) {
        let t = shopItem.dictionaryRepresentation()
        ref.child(JSONKeys.shoppingitem).child(shopItem.id).setValue(t)
    }
    
    public func removeShopItem(_ shopItem: ShoppingItems) {
        ref.child(JSONKeys.shoppingitem).child(shopItem.id).removeValue()
    }
    
}



/* OLD CODE
 
 // ======== EXPLICIT SWIFT STEPS ========
 //let shoppingItemArray = data[JSONKeys.shoppingitem] //print(data)
 //let shoppingModelsDataArray = ShoppingItems.modelsFromDictionaryArray(array: shoppingItemArray as! NSArray)
 
 // ======== HELPER FUNCTIONS FROM JSON4SWIFT ========
 //                let json4SwiftObject = Json4Swift_Base.init(dictionary: data)
 //                let shoppingData = [JSONKeys.shoppingitem: json4SwiftObject?.shoppingItems]
 
 */



