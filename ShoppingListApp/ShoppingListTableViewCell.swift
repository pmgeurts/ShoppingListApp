//
//  ShoppingListTableViewCell.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 29/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    func setDataForTableCell(shoppingListItem: ShoppingItems) {
        
        self.titleLable?.text = shoppingListItem.name
        self.shoppingListImageView?.image = UIImage.init(named: "Screen1")
        //FORMAT .00 with , keyboard in EUROPE
        self.detailTextView?.text = String(format: "€ %.02f", arguments: [shoppingListItem.price ?? 0])
        //FORMAT . America , Europe 
        //self.detailTextView?.text = String(format: "€ %.02f", locale: Locale.current arguments: [shoppingListItem.price ?? 0])
        
        //FORMAT .0 
        //self.detailTextView?.text = String("Price: \(shoppingListItem.price ?? 0)")?.doubleValue
    }

    @IBOutlet weak var shoppingListImageView: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
