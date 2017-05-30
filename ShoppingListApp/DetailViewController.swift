//
//  DetailViewController.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 30/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var theItem: ShoppingItem?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameField.text = theItem?.name
        self.priceField.text = theItem?.price
        self.descriptionLabel.text = theItem?.detailDescription
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation


    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true) //closes the keyboard
        
        //save the items...
        theItem?.name = nameField.text!
        theItem?.price = priceField.text!
        theItem?.detailDescription = descriptionLabel.text!
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        //specifiek:     textFieldOutlet.resignFirstResponder()
        view.endEditing(true)
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
