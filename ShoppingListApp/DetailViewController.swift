//
//  DetailViewController.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 30/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var theItem: ShoppingItems!
    var imageStore: ImageStore!

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameField.text = theItem?.name
        if let priceDouble = theItem?.price {
            priceField.text = "\(priceDouble)"
        }
        //priceField.text = theItem?.price
        descriptionLabel.text = theItem?.description
        let id = theItem?.id
        let imageToDisplay = imageStore.image(forKey: id!)
        imageView.image = imageToDisplay
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true) //closes the keyboard
        
        //save the items...
        if let name = nameField.text {
            theItem?.name = name
        }
        
        if let priceText = priceField.text,
            let priceDouble = Double(priceText) {
            theItem?.price = priceDouble
        }
        //theItem?.price = priceField.text!
        theItem?.description = descriptionLabel.text!
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        //specifiek:     textFieldOutlet.resignFirstResponder()
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            //imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            
        } else {
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func clearImage(_ sender: Any) {
        if imageView.image != nil {
            imageView.image = nil
        } else {
            let alert = UIAlertController(title: "No Image Set", message: "There must be an image present before you can delete it :)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //Get picked image from info dict
        //let image = info[UIImagePickerControllerEditedImage] as! UIImage
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //Store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: (theItem?.id)!)
        
        //Put that image on the screen in the image view
        imageView.image = image
        
        // Take image picker off the screen - you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }

    
    
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        if gestureRecognizer is UITapGestureRecognizer {
//            let location = touch.location(in: tableView)
//            print("Tap in table")
//            
//            return (tableView.indexPathForRow(at: location) == nil)
//        }
//        print("is UITapGestureRecognizer")
//        return true
//    }

}
