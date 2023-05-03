//
//  DetailedRecipeTableViewController.swift
//  WhatIsInMyFridgeApp
//
//  Created by test11 on 01/09/2022.
//

import UIKit

class DetailedRecipeTableViewController: UITableViewController {
    var networkService : SpoonculaService? = nil
    var recipeForDisplay : RecipeByIngredients? = nil
    var fullRecipe : FullRecipe? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let networkService = self.networkService,
              let recipeForDisplay = self.recipeForDisplay else {
            return
        }
        Task {
            fullRecipe = await networkService.getFullRecipe ( id: recipeForDisplay.id )
        }
        
        tableView.dataSource = self
        // TODO: - header
        tableView.tableHeaderView = UIView()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

//    var data: [String: Any] = ["summery":,"Ingredients" : []]
    var sectionTitles = ["Recipe's info","Ingredients"]

    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            break
        case 1:
         let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsRecipeTableViewCell", for: indexPath) as! IngredientsRecipeTableViewCell
        cell.shortRecipe = recipeForDisplay
        default:
            break
        }
        return UITableViewCell()
    }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
//           view.backgroundColor =  colorLiteral(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)
//
//           let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
//           lbl.font = UIFont.systemFont(ofSize: 20)
//           lbl.text = mobileBrand[section].brandName
//           view.addSubview(lbl)
//           return view
//         }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
