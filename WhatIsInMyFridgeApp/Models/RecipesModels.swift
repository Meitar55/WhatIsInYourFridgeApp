//
//  RecipesModels.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 01/08/2022.
//

import Foundation

struct DishType : Decodable {
    let name : String
}

struct Cuisuin : Decodable {
    let name : String
}

struct AnalyzedRecipe : Decodable {
    let instructions : String
}

struct EquipmentItem : Decodable {
    let name : String
}

struct EquipmentByRecipe : Decodable {
    let equipment : [EquipmentItem]
}

struct Nutrient {
    let name : String
    var minAmount : Double = -1
    var maxAmount : Double = -1
    
    var parsedName : String {
        if let firstChar = name.first {
            var nameCopy = name
            nameCopy.removeFirst()
            return firstChar.uppercased()+nameCopy
        }
        return ""
    }
}

struct NutrientsResponse : Decodable {
    let recipes : [RecipeByNutrients]
}

struct RecipeByNutrients : Decodable {
    let id : Int
    let title : String
    let image : String
    
    let calories : Int
    let fat : String
    let protein : String
    let carbs : String
}

struct Ingredient : Decodable {
    let id : Int
    let image : String
    let unit : String
    let name : String
    let amount : Double
    let meta : [String]
}

struct IngredientsResponse : Decodable {
    let recipes : [RecipeByIngredients]
}

struct RecipeByIngredients : Decodable {
    let id : Int
    let image : String
    let title : String
    
    let usedIngredients : [Ingredient]
    let usedIngredientCount : Int
    let missedIngredientCount : Int
    let missedIngredients : [Ingredient]
    let matchingPercentage : Double
}

struct FullRecipe : Decodable {
    let readyInMinutes : Int
    let servings : Int
    let creditsText : String
    let cuisines : [Cuisuin]
    let dishTypes : [DishType]
    let dairyFree : Bool
    let glutenFree : Bool
    let vegan : Bool
    let vegetarian : Bool
    let summery : String

    var nutrientsData : RecipeByNutrients?
    var instructionsOfRecipe : AnalyzedRecipe?
    var equipment : EquipmentByRecipe?
}
