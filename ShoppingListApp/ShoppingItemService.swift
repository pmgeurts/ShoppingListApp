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
                print(snapshot.key)
                
                // ======== EXPLICIT SWIFT STEPS TO DICTIONARY ========
                let shoppingtems = data[JSONKeys.shoppingitem] as! NSDictionary
                //print(data)
                let shoppingModelsDataArray = ShoppingItems.modelsFromDictionaryOf(dictionaries: shoppingtems)
                //print(shoppingModelsDataArray)
                // ======== EXPLICIT SWIFT STEPS ========
                //let shoppingItemArray = data[JSONKeys.shoppingitem] //print(data)
                //let shoppingModelsDataArray = ShoppingItems.modelsFromDictionaryArray(array: shoppingItemArray as! NSArray)
                
                // ======== HELPER FUNCTIONS FROM JSON4SWIFT ========
                //                let json4SwiftObject = Json4Swift_Base.init(dictionary: data)
                //                let shoppingData = [JSONKeys.shoppingitem: json4SwiftObject?.shoppingItems]
                
                let shoppingDataDict = [JSONKeys.shoppingitem: shoppingModelsDataArray]
                NotificationCenter.default.post(name: Notification.Name(rawValue: "gotShoppingListData"), object: self , userInfo: shoppingDataDict)
                //print(shoppingDataDict)
                
            } else {
                print("Error while retrieving data from Firebase")
            }
        })
    
        ref.observe(.childAdded, with: { (snapshot) -> Void in
            print("childAdded")
        })
        
        ref.observe(.childRemoved, with: { (snapshot) -> Void in
            print("childRemoved")
        })
        
    }
    

    public func addShopItem(shopItem: ShoppingItems) {
        //ref.child(<TOP KEY FIREBASE e.g. ShoppingItems>).child(<UNIQUE ID>).setValue(<DICTIONARY>)
        let t = shopItem.dictionaryRepresentation()
        ref.child(JSONKeys.shoppingitem).child(shopItem.id).setValue(t)
    }

    public func removeShopItem(_ shopItem: ShoppingItems) {
        //ref.child("ShoppingItems").child(shopID).removeValue()
        //let r = shopItem.dictionaryRepresentation()
        print(shopItem.id)
        ref.child(JSONKeys.shoppingitem).child(shopItem.id).removeValue()
    }
    
    
}







