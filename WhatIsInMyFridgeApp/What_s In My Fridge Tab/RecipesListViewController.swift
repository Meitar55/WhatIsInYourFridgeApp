//
//  RecipesListViewController.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 15/08/2022.
//

import UIKit

class RecipesListViewController: UIViewController {
    var networkService : SpoonculaService? = nil
    var chosenIngredients : [IngredientShortData]? = nil
    var recipes = [RecipeByIngredients]()
    @IBOutlet weak var recipesListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesListTableView.dataSource = self
        getResponseRecipesList()
        // Do any additional setup after loading the view.
    }
    
    private func getResponseRecipesList() {
        guard let networkService = self.networkService else {
            print("ERROR: getResponseRecipesList >> RecipesListViewController")
            return
        }
        Task{
            if let chosenIngredients = self.chosenIngredients{
                var recipes = await networkService.getRecipesByIngredients(ingredientsList: chosenIngredients)
                recipes = recipes.sorted { recipe1, recipe2 in
                    recipe1.matchingPercentage >= recipe2.matchingPercentage
                }
                self.recipes = recipes
                self.recipesListTableView.reloadData()
           }
       }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "displayChosenRecipeSegue",
           let recipeVC = segue.destination as? DetailedRecipeTableViewController,
           let recipeCell = sender as? RecipesListTableViewCell,
           let recipe = recipeCell.recipe {
            recipeVC.networkService = networkService
            recipeVC.recipeForDisplay = recipe
        }
    }
}

// MARK: tableViewDataSource
extension RecipesListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipesListTableView.dequeueReusableCell(withIdentifier: "RecipesListTableViewCell") as! RecipesListTableViewCell
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        return cell
    }
}


