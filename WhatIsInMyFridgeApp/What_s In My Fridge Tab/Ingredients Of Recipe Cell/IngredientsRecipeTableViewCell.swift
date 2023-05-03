//
//  IngredientsRecipeTableViewCell.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 01/09/2022.
//

import UIKit

class IngredientsRecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var ingredientsDisplayTableView: UITableView!
    
    var shortRecipe : RecipeByIngredients? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ingredientsDisplayTableView.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension IngredientsRecipeTableViewCell : UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0){
            return "What you have:"
        }
        if (section == 1){
            return "What you miss:"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let shortRecipe = self.shortRecipe else {
            return 0
        }
        if section == 0 {
            return shortRecipe.usedIngredientCount
        }
        else if section == 1 {
            return shortRecipe.missedIngredientCount
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsDisplayTableView.dequeueReusableCell(withIdentifier: "RecipeIngredientTableViewCell") as! IngredientTableViewCell
        switch indexPath.section {
        case 0:
            let ingredient = shortRecipe?.usedIngredients[indexPath.row]
            cell.ingredient = ingredient
        case 1:
            let ingredient = shortRecipe?.missedIngredients[indexPath.row]
            cell.ingredient = ingredient
        default:
            return UITableViewCell()
        }
        return cell
    }
}

