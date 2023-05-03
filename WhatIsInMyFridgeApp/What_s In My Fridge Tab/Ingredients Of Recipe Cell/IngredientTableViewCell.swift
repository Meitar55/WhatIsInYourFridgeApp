//
//  UsedIngredientsTableViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 05/09/2022.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var usedIngredientUnitsLabel: UILabel!
    @IBOutlet weak var usedIngredientAmountLabel: UILabel!
    @IBOutlet weak var usedIngredientNameLabel: UILabel!
    
    var ingredient: Ingredient? = nil {
        didSet {
            setUpIngredientCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUpIngredientCell() {
        guard let ingredient = self.ingredient else {
            return
        }
        
        usedIngredientNameLabel.text = ingredient.name
        let amount = ingredient.amount
        usedIngredientAmountLabel.text = amount != nil ? String(amount) : ""
        usedIngredientUnitsLabel.text = ingredient.unit
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
