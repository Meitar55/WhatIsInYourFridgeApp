//
//  DetailedRecipeViewController.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 30/08/2022.
//

import UIKit

class DetailedRecipeViewControllerIdea: UIViewController {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTagsStackView: UIStackView!
    @IBOutlet weak var recipeSummeryLabel: UILabel!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    var fullRecipe : FullRecipe? = nil
    var networkService : SpoonculaService? = nil
    var recipeForDisplay : RecipeByIngredients? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let networkService = self.networkService,
              let recipeForDisplay = self.recipeForDisplay else {
            return
        }
        Task {
            fullRecipe = await networkService.getFullRecipe ( id: recipeForDisplay.id )
        }
        setUpRecipe()
        
    }
    
    private func setUpRecipe () {
       
        //title
        recipeTitleLabel?.text = recipeForDisplay!.title
        //image
        if let imageView = recipeImageView {
            let imageUrl = "https:spoonacular.com/recipeImages/\(recipeForDisplay!.id)-240x150.\(recipeForDisplay!.imageType)"
            Task{
                await imageView.loadImage(urlString: imageUrl)
            }
        }
        // ingredients
        
        if let fullRecipe = self.fullRecipe{
            // summery
            recipeSummeryLabel.text = fullRecipe.summery
            // tags
            // equipment
            // instructions
            // more ?
        }
    }
}
