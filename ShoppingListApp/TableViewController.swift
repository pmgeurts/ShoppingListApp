//
//  TableViewController.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 24/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit



var currentItem: ShoppingItems?



class TableViewController: UITableViewController, UITextFieldDelegate {
    
    
    var shoppingListItems: [ShoppingItems] = [] {
        didSet {
            
            
            self.tableView.reloadData()
            
            
        }
    }
    
    
    @IBOutlet weak var textFieldOutlet: UITextField!
    
    @IBAction func addItem(_ sender: Any ) {
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "New Item", message: "Enter the item name and price", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "The Item Name"
        }
        
        alert.addTextField { (priceField) in
            priceField.keyboardType = .decimalPad
            priceField.placeholder = "The New Price"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Add Item", style: .default, handler: { [weak alert] (_) in

 /*
 "2.25".doubleValue // 2.25
 "2,25".doubleValue // 2.25
 
 let price = "2,25"
 let costString = String(format:"%.2f", price.doubleValue)   // "2.25"
 */
           /* print(priceField)
            priceField = String(priceField.doubleValue)
            print(priceField)
            */
            
            
            
            if let textField = alert?.textFields?[0].text,
                let priceField = alert?.textFields?[1].text,
                let priceDouble = Double(priceField)
            {
                
                // Force unwrapping because we know it exists.
                // shoppingListItems.append([textField.text, priceField.text])
                let newItem = ShoppingItems.init(name: textField, price: priceDouble, description: "")
                ShoppingItemService.sharedInstance.addShopItem(shopItem: newItem)
                self.shoppingListItems.insert(newItem, at: 0)
                
            }
            
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: tableCellIDs.shoppingListID, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: tableCellIDs.shoppingListID)
        
        ShoppingItemService.sharedInstance.getShoppingListData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.notifyObservers), name: NSNotification.Name(rawValue: "gotShoppingListData"), object: nil)
        
    }
    
    func notifyObservers(notification: NSNotification) {
        var shopItemDict = notification.userInfo as! Dictionary<String, [ShoppingItems]>
        shoppingListItems = shopItemDict[JSONKeys.shoppingitem]!
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
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
        
        let cell: ShoppingListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: tableCellIDs.shoppingListID, for: indexPath) as! ShoppingListTableViewCell
        let currentShoppingItem = shoppingListItems[indexPath.row]
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem = shoppingListItems[indexPath.row]
        self.performSegue(withIdentifier: segueKeys.detailView, sender: self)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == segueKeys.detailView {
            let detailView = segue.destination as! DetailViewController
            detailView.theItem = currentItem
            
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            // Delete the row from the data source
            ShoppingItemService.sharedInstance.removeShopItem(shoppingListItems[indexPath.row])
            shoppingListItems.remove(at: indexPath.row)
            
            //let newItem = ShoppingItems.init(name: textField, price: priceDouble, description: "")
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
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
