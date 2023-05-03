//
//  IngredientsSearchTableViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 08/08/2022.
//

import UIKit

class IngredientsSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var IngredientNameLabel: UILabel!
    @IBOutlet weak var IngredientImageView: UIImageView!
    
    var ingredient: IngredientShortData? = nil{
        didSet{
            IngredientNameLabel.text = ingredient?.name
            let path = "https://spoonacular.com/cdn/ingredients_100x100/"
            if let imageName = ingredient?.image,
               let imageView = IngredientImageView{
                let imageUrl = path + imageName

                Task{
                    await imageView.loadImage(urlString: imageUrl)
                }
            }
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
