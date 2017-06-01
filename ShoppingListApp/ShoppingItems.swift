/*
 Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class ShoppingItems {
    public var name : String?
    public var price : Double?
    public var description : String?
    public var id = NSUUID().uuidString
    
    init(name: String, price: Double, description: String) {
        self.name = name
        self.price = price
        self.description = description
    }
    
    //Array of Dictionaries
    public class func modelsFromDictionaryOf(dictionaries:NSDictionary) -> [ShoppingItems] {
        var modelino:[ShoppingItems] = []
        for (_ , value) in dictionaries {
                modelino.append(ShoppingItems(dictionary: value as! NSDictionary)!)
        }
        
        return modelino
    }
        
    
    
    /**
     Returns an array of models based on given dictionary.
     Sample usage: let shoppingItems_list = ShoppingItems.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     - parameter array:  NSArray from JSON dictionary.
     - returns: Array of ShoppingItems Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [ShoppingItems]
    {
        var models:[ShoppingItems] = []
        for item in array
        {
            models.append(ShoppingItems(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     Sample usage: let shoppingItems = ShoppingItems(someDictionaryFromJSON)
     - parameter dictionary:  NSDictionary from JSON.
     - returns: ShoppingItems Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        price = dictionary["price"] as? Double
        description = dictionary["description"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.price, forKey: "price")
        dictionary.setValue(self.description, forKey: "description")
        
        return dictionary
    }
    
}
