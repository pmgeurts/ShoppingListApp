//
//  ShoppingListTableViewCell.swift
//  ShoppingListApp
//
//  Created by Paul Geurts on 29/05/2017.
//  Copyright © 2017 PG. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    
    func setDataForTableCell(shoppingListItem: ShoppingItem) {
        
        self.titleLable?.text = shoppingListItem.name
        self.shoppingListImageView?.image = UIImage.init(named: "Screen1")
        self.detailTextView?.text = "€ \(shoppingListItem.price)"
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
