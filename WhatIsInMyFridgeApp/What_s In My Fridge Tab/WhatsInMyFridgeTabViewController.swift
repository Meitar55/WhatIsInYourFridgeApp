//
//  WhatsInMyFridgeTabViewController.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 11/08/2022.
//

import UIKit

class WhatsInMyFridgeTabViewController: UIViewController {
    @IBOutlet weak var chosenIngredientsCollectionView: UICollectionView!
    var chosenIngredients = [IngredientShortData]()
    var networkService : SpoonculaService? = SpoonculaService() // when to inject ?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "IngredientsSearchNavigationController") as? UINavigationController
        else {
            return
        }
        setUpSheetView(navigationController: navigationController)
        // TODO: add remove from chosen list functionality
        
        chosenIngredientsCollectionView.dataSource = self
    }
    
    
    private func setUpSheetView(navigationController nvc: UINavigationController) {
        if let sheet = nvc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        if let sheet = nvc.viewControllers.first as? IngredientsSearchSheetViewController{
            sheet.delegate = self
            sheet.networkService = networkService
        }
        
        self.present(nvc, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRecipesTableSegue"
        {
            if let recipesListVC = segue.destination as? RecipesListViewController {
                recipesListVC.networkService = networkService
                recipesListVC.chosenIngredients = chosenIngredients
            }
        }
        else if segue.identifier == "returnToSearchIngredientsSegue" {
            if let navigationController = self.storyboard?.instantiateViewController(withIdentifier: "IngredientsSearchNavigationController") as? UINavigationController {
                setUpSheetView(navigationController: navigationController)
            }
        }
    }
}

extension WhatsInMyFridgeTabViewController : IngredientsSearchDelegate {
    func addToChosenIngredients(ingredientToAdd: IngredientShortData) {
        for ing in chosenIngredients{
            if ing.id == ingredientToAdd.id{
                return
            }
        }
        chosenIngredients.append(ingredientToAdd)
        chosenIngredientsCollectionView.reloadData()
    }
}

extension WhatsInMyFridgeTabViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chosenIngredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chosenIngredientsCollectionView.dequeueReusableCell(withReuseIdentifier: "ChosenIngredientCollectionViewCell", for: indexPath) as! ChosenIngredientCollectionViewCell
        cell.chosen = chosenIngredients[indexPath.row]
        return cell
    }
    
    // TODO: remove functionality
    //    func collectionView(_ collectionView: UICollectionView, commit editingStyle: UICollectionViewCell.EditingStyle, cellForItemAt indexPath: IndexPath) {
    //        if (editingStyle == .delete) {
    //
    //
    //        }
    //    }
}

