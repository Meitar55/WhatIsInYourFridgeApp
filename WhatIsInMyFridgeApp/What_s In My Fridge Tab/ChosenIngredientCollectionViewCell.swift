//
//  ChosenIngredientCollectionViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 10/08/2022.
//

import UIKit

class ChosenIngredientCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientImageView: UIImageView!
    var chosen : IngredientShortData? = nil {
        didSet{
            ingredientNameLabel.text = chosen?.name
            let path = "https://spoonacular.com/cdn/ingredients_100x100/"
            if let imageName = chosen?.image,
               let imageView = ingredientImageView{
                let imageUrl = path + imageName

                Task{
                    await imageView.loadImage(urlString: imageUrl)
                }
            }
        }
    }
    // TODO: remove functionality
    
}
