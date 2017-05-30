//
//  TableViewController.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 24/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
   

    var shoppingListItems: [ShoppingItem] = [] {
        didSet {
            UIView.transition(with: tableView,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
            //self.tableView.reloadData()

 
 
 
        }
    }
    /*
    var shoppingListItems: [String] = ["Groente", "Fruit", "Pasta", "Broodje", "Yoghurt"] {
        didSet {
            self.tableView.reloadData()

        }
    }
    
    var shoppingItemArray: [ShoppingItem] {
        didSet {
            self.tableView.reloadData()
            
        }
    }*/
    
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func addItem(_ sender: Any ) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Item", message: "Enter the item name and price", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "The Item Name"
        }
        
        alert.addTextField { (priceField) in
            priceField.keyboardType = .numberPad
            priceField.placeholder = "The New Price"
        }
        
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { [weak alert] (_) in
            
            if let textField = alert?.textFields?[0].text,
                let priceField = alert?.textFields?[1].text {
            
                // Force unwrapping because we know it exists.
                // shoppingListItems.append([textField.text, priceField.text])
                let newItem = ShoppingItem.init(name: textField, price: priceField == "" ? 0 : Int(priceField)!)
                
                self.shoppingListItems.insert(newItem, at: 0) //-=-=-=-=-=-=-=-
                
                //*** ANIMATION TEST ***
                //let indexPath = NSIndexPath(row: 0, section: 0)
                //tableView.insertRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
                
                //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                // add message to current array
                //myArray.insert("Horse", atIndex: 0)
                
                // insert row in table
                //let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                //tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
            }
            
            
            //print("Text field: \(textField.text)")
            //print("Price field: \(priceField.text)")
        }))
        
        // 4. Present the alert.
        
        print(self.present(alert, animated: true, completion: nil))
    }
    
    @IBAction func edit(_ sender: Any) {
        if isEditing {
            setEditing(false, animated: true)
        } else {
            setEditing(true, animated: true)
            
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        //specifiek:     textFieldOutlet.resignFirstResponder()
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: tableCellIDs.shoppingListID, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: tableCellIDs.shoppingListID)
        shoppingListItems = ShoppingItemService.getTheDataFromShoppingService()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingListItems.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        // Configure the cell...
        /*        cell.textLabel?.text = "Item\(indexPath.row): \(shoppingListItems[indexPath.row])"
         cell.imageView?.image = #imageLiteral(resourceName: "grocery")
         
         return cell
         }
         */
        
        let cell: ShoppingListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: tableCellIDs.shoppingListID, for: indexPath) as! ShoppingListTableViewCell
        
        //b)
        let currentShoppingItem = shoppingListItems[indexPath.row]
        //c)
        cell.setDataForTableCell(shoppingListItem: currentShoppingItem)
        cell.imageView?.image = #imageLiteral(resourceName: "grocery")
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            // Delete the row from the data source
            shoppingListItems.remove(at: indexPath.row)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            print("Tap in table")
            
            return (tableView.indexPathForRow(at: location) == nil)
        }
        print("is UITapGestureRecognizer")
        return true
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let itemToMove = shoppingListItems[fromIndexPath.row]
        shoppingListItems.remove(at: fromIndexPath.row)
        shoppingListItems.insert(itemToMove, at: to.row)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
