//
//  RecipesListTableViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 15/08/2022.
//

import UIKit

class RecipesListTableViewCell: UITableViewCell {

    @IBOutlet weak var matchingPercentsOfRecipeLabel: UILabel!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    
    var recipe : RecipeByIngredients? = nil{
        didSet{
            recipeNameLabel.text = recipe?.title
            if let matchingPercentage = recipe?.matchingPercentage,
               let imageView = recipeImageView {
                var percents = chopDouble(matchingPercentage)
                percents += "%"
                matchingPercentsOfRecipeLabel.text = percents
                let imageUrl = "https://spoonacular.com/recipeImages/\(recipe!.id)-90x90.\(recipe!.imageType)"
                /*
                 https://spoonacular.com/recipeImages/{ID}-{SIZE}.{TYPE}
                 */
                Task{
                    await imageView.loadImage(urlString: imageUrl)
                }
            }
        }
    }
    
    private func chopDouble(_ a: Double) -> String {
        let stringArr = String(a).split(separator: ".")
        let decimals = Array(stringArr[1])
        var string = "\(stringArr[0])."

        var count = 0;
        for n in decimals {
            if count == 2 { break }
            string += "\(n)"
            count += 1
        }
        return string
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
