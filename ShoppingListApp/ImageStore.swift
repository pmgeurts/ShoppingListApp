//
//  ImageStore.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 02/06/2017.
//  Copyright © 2017 PG. All rights reserved.
//


import UIKit

class ImageStore {
//    public static let sharedInstance = ImageStore()  // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
//    
//    private init() { // Singleton: https://en.wikipedia.org/wiki/Singleton_pattern
//    }
    
    let cache = NSCache<NSString,UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
        
        //Create full URL for image
        let url = imageURL(forKey: key)
        
        //Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 1) {
            //Write it to full URL
            let _ = try? data.write(to: url, options: [.atomic])
            
        }
    }
    
    func image(forKey key: String) -> UIImage? {
        //return cache.object(forKey: key as NSString)
        if let existingImage = cache.object(forKey: key as NSString) {
            return existingImage
        }
        let url = imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else {
            return nil
        }
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
    }
    
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
        
        let url = imageURL(forKey: key)
        do {
            try FileManager.default.removeItem(at: url)
        } catch let deleteError {
            print("Error removing the image from disk: \(deleteError)")
        }
    }
    
    func imageURL(forKey key: String) -> URL {
        
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = documentsDirectories.first!
        
        return documentsDirectory.appendingPathComponent(key)
    }
    
}
