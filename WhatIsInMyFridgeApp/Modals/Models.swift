//
//  Models.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 02/08/2022.
//

import Foundation

struct DishType : Decodable {
    let name : String
}

struct Cuisuin : Decodable {
    let name : String
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

//struct IngredientsResponse : Decodable {
//    let recipes : [RecipeByIngredients]
//}

struct RecipeByIngredients : Decodable {
    let id : Int
    let image : String
    let title : String
    let imageType : String
    
    let usedIngredients : [Ingredient]
    let usedIngredientCount : Int
    let missedIngredientCount : Int
    let missedIngredients : [Ingredient]
    var matchingPercentage : Double {
        return (Double(usedIngredientCount) / Double(usedIngredientCount + missedIngredientCount))*100
    }
}

struct FullRecipe : Decodable {
    let readyInMinutes : Int
    let servings : Int
    let creditsText : String?
    let cuisines : [String]//[Cuisuin]
    let dishTypes : [String]//[DishType]
    let instructions : String?
    let dairyFree : Bool
    let glutenFree : Bool
    let vegan : Bool
    let vegetarian : Bool
    let summery : String?
    
    var nutrientsData : RecipeByNutrients?
    var equipmentData : EquipmentByRecipe?
}

struct AutocompleteSearchRecipeData : Decodable {
    let id : Int
    let title : String
}

struct RecipeShortData : Decodable {
    let id : Int
    let image : String
    let title : String
    let readyInMinutes : Int
    let dairyFree : Bool
    let glutenFree : Bool
    let vegan : Bool
    let vegetarian : Bool
}

struct AutocompleteSearchIngredients: Decodable {
    let results: [IngredientShortData]
    let totalResults : Int
}

struct IngredientShortData : Decodable {
    let id : Int
    let image : String
    let name : String
}
