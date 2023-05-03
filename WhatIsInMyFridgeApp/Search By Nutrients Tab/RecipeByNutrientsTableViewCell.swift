//
//  RecipeByNutrientsTableViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 21/08/2022.
//

import UIKit

class RecipeByNutrientsTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
