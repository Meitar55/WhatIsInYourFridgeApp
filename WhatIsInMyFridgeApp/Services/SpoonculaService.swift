//
//  SpoonculaService.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 01/08/2022.
//

import Foundation
import UIKit

class SpoonculaService {
    
    let apiKey = "17356a41f3d8491fb7ea57aaabb0af4a"
    
    
    /** https://api.spoonacular.com/recipes/716429/information?includeNutrition=false
     https://api.spoonacular.com/recipes/1003464/nutritionWidget.json   */
    func serviceURLComponents(for pathSuffix : String) -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "\(pathSuffix)"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            
        ]
        return components
    }
    
    func getRecipesByIngredients (ingredientsList: [IngredientShortData]) async-> [RecipeByIngredients] {
        /** https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,+sugar&number=2  */
        guard let url = createURLForIngredients(pathSuffix: "/recipes/findByIngredients" ,ingredientsList: ingredientsList) else {
            print("ERROR with URL: getRecipesByIngredients")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([RecipeByIngredients].self, from: data)
            return response
        } catch {
            print("ERROR: getRecipesByIngredients", error)
            return []
        }
    }
    
    private func createURLForIngredients (pathSuffix: String, ingredientsList: [IngredientShortData]) -> URL?{
        var components = serviceURLComponents(for: pathSuffix)
        var ingredientsRequested = String()
        for ing in ingredientsList {
            ingredientsRequested.append(","+ing.name)
        }
        ingredientsRequested.removeFirst()
        components.queryItems?.append(URLQueryItem(name: "ingredients", value: ingredientsRequested))
        
        let url = components.url
        return url
    }
    
    private func createURLForNutrients (pathSuffix: String, nutrientsList: [Nutrient]) -> URL?{
        var components = serviceURLComponents(for: pathSuffix)
        for nut in nutrientsList {
            if !nut.parsedName.isEmpty {
                if nut.maxAmount != -1{
                    components.queryItems?.append(URLQueryItem(name: "max\(nut.parsedName)", value: String(nut.maxAmount)))
                }
                if nut.minAmount != -1{
                    components.queryItems?.append(URLQueryItem(name: "min\(nut.parsedName)", value: String(nut.minAmount)))
                }
            }
        }
        let url = components.url
        return url
    }
    
    func getRecipesByNutrients (nutrientsList: [Nutrient]) async-> [RecipeByNutrients] {
        /** https://api.spoonacular.com/recipes/findByNutrients?minCarbs=10&maxCarbs=50&number=2  */
        guard let url = createURLForNutrients(pathSuffix: "/recipes/findByNutrients" ,nutrientsList: nutrientsList) else {
            print("ERROR with URL: getRecipesByNutrients")
            return []
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(NutrientsResponse.self, from: data)
            return response.recipes
        } catch {
            print("ERROR: getRecipesByNutrients", error)
            return []
        }
    }
    
    func getRecipeEquipment ( id : Int ) async -> EquipmentByRecipe? {
        /** https://api.spoonacular.com/recipes/1003464/equipmentWidget.json    */
        guard let url = serviceURLComponents(for: "/recipes/\(id)/equipmentWidget.json").url else {
            print("ERROR with URL: getRecipeEquipment")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(EquipmentByRecipe.self, from: data)
            return response
        } catch {
            print("ERROR: getRecipeEquipment", error)
            return nil
        }
    }
    
    func getRecipeNutrients( id : Int ) async -> RecipeByNutrients? {
        /** https://api.spoonacular.com/recipes/1003464/nutritionWidget.json    */
        guard let url = serviceURLComponents(for: "/recipes/\(id)/nutritionWidget.json").url else {
            print("ERROR with URL: getRecipeNutrients")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(RecipeByNutrients.self, from: data)
            return response
        } catch {
            print("ERROR: getRecipeNutrients", error)
            return nil
        }
    }
    
    func getFullRecipe ( id : Int ) async -> FullRecipe? {
        /** https://api.spoonacular.com/recipes/716429/information?includeNutrition=false   */
        guard let url = serviceURLComponents(for: "/recipes/\(id)/information").url else {
            print("ERROR with URL: getFullRecipe")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            var response = try JSONDecoder().decode(FullRecipe.self, from: data)
            async let equipment = getRecipeEquipment(id: id)
            async let nutrients = getRecipeNutrients(id: id)
            response.nutrientsData = await nutrients
            response.equipmentData = await equipment
            return response
        } catch {
            print("ERROR: getFullRecipe", error)
            return nil
        }
    }
    
    func getShortRecipe ( id : Int ) async -> RecipeShortData? {
        /** https://api.spoonacular.com/recipes/716429/information?includeNutrition=false   */
        guard let url = serviceURLComponents(for: "/recipes/\(id)/information").url else {
            print("ERROR with URL: getShortRecipe")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(RecipeShortData.self, from: data)
            return response
        } catch {
            print("ERROR: getShortRecipe", error)
            return nil
        }
    }
    
    func searchRecipesByName ( searched : String ) async -> [RecipeShortData] {
        /** https://api.spoonacular.com/recipes/autocomplete?number=10&query=chick  */
        var components = serviceURLComponents(for: "/recipes/autocomplete")
        components.queryItems?.append(URLQueryItem(name: "query", value: searched))
        guard let url = components.url else {
            print("ERROR with URL: searchRecipesByName")
            return []
        }
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([AutocompleteSearchRecipeData].self, from: data)
            let allResults = await withTaskGroup(of: RecipeShortData.self){ group -> [RecipeShortData] in
                for rec in response{
                    group.addTask{
                        if let recipe = await self.getShortRecipe(id: rec.id){
                            return recipe
                        }
                     //   return recipe!
                        return RecipeShortData(id: 0, image: "0", title: "0", readyInMinutes: 0, dairyFree: false, glutenFree: false, vegan: false, vegetarian: false)
                    }
                }
                var childTaskResults = [RecipeShortData]()
                for await result in group {
                    childTaskResults.append(result)
                }
                return childTaskResults
            }
            return allResults
        }
        catch {
            print("ERROR: searchRecipesByName", error)
            return []
        }
    }
    
    func searchIngredientsByName (searched : String) async -> AutocompleteSearchIngredients? {
    /** https://api.spoonacular.com/food/ingredients/search?query=banana&number=2&sort=calories&sortDirection=desc  */
    var components = serviceURLComponents(for: "/food/ingredients/search")
    components.queryItems?.append(URLQueryItem(name: "query", value: searched))
    guard let url = components.url else {
        print("ERROR with URL: searchIngredientsByName")
        return nil
    }
    do {
        let (data,_) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(AutocompleteSearchIngredients.self, from: data)
        return response
    }
        catch {
            print("ERROR: searchRecipesByName", error)
            return nil
        }
    }
    
}
