//
//  IngredientsSearchSheetViewController.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 08/08/2022.
//

import UIKit

protocol IngredientsSearchDelegate {
    func addToChosenIngredients ( ingredientToAdd: IngredientShortData )
}

class IngredientsSearchSheetViewController : UIViewController {
    @IBOutlet weak var ingredientsResultsTableView: UITableView!
    
    var networkService : SpoonculaService? = nil
    let searchController = UISearchController()
    var ingredientsBySearch = [IngredientShortData]()
    var delegate : IngredientsSearchDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsResultsTableView.dataSource = self
        ingredientsResultsTableView.delegate = self
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    private func getIngredients(){
        Task{
            if let searchString = searchController.searchBar.text,
               !searchString.isEmpty,
               searchString.count > 2,
              let fetchedIngerdients = await networkService?.searchIngredientsByName(searched: searchString)?.results{
                self.ingredientsBySearch = fetchedIngerdients
                self.ingredientsResultsTableView.reloadData()
            }
        }
    }
}

// MARK: Table View Data Source
extension IngredientsSearchSheetViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredientsBySearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ingredientsResultsTableView.dequeueReusableCell(withIdentifier: "IngredientsSearchTableViewCell") as! IngredientsSearchTableViewCell
        let ingredient = ingredientsBySearch[indexPath.row]
        cell.ingredient = ingredient
        return cell
    }
}

// MARK: Table View Delegate
extension IngredientsSearchSheetViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            return
        }
        let chosen = ingredientsBySearch[indexPath.row]
        delegate.addToChosenIngredients(ingredientToAdd: chosen)
    }
}

// MARK: Search Results Updating
extension IngredientsSearchSheetViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        getIngredients()
    }
}
