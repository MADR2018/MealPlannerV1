//
//  tableDetailViewController.swift
//  FBApp
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class tableDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var pictureList = [String]()
    var ingredientsList: [String] = []
    var instructionList: [String] = []
    
    
    @IBOutlet weak var receipeTableView: UITableView!
    
    @IBOutlet weak var selectedFoodImage: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    var receipeNamePassed : String = ""
    
    @IBAction func IngredientsButton(_ sender: UIButton) {
        pictureList.removeAll()
        pictureList = ingredientsList
        self.receipeTableView.reloadData()
    }
    
    @IBAction func InstructionsButton(_ sender: Any) {
        pictureList.removeAll()
        pictureList = instructionList
        self.receipeTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receipeTableView.delegate = self
        receipeTableView.dataSource = self
        
        // set the text and image from datapass from tableviewCellController
        foodLabel.text = receipeNamePassed
        selectedFoodImage.image = UIImage(named: receipeNamePassed)
        
        //get data from firebase
        retrieveMessages()
        
        
      
    }
    
    // load the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receipesCell", for: indexPath)
        cell.textLabel?.text = pictureList[indexPath.row]
        cell.textLabel?.numberOfLines = 10;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    // retrieveMessages from firebase
    func retrieveMessages(){
        
        let receipeDB = Database.database().reference().child("Recipes").child(receipeNamePassed)
        receipeDB.observeSingleEvent(of:.value){(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let tempIngredients = snapshotValue["Ingredients"]!
            let tempInstruction = snapshotValue["Instructions"]!
            //print("what is in the temp \(tempIngredients)" )
            //print(tempIngredients.split(separator: "#"))
            let tempArrayIngredients = tempIngredients.split(separator: "#")
            let tempArrayInstructions = tempInstruction.split(separator: "#")
            for singleItem in tempArrayIngredients{
                self.pictureList.append(String(singleItem))
            }
            for singleItem2 in tempArrayInstructions{
                self.instructionList.append(String(singleItem2))
            }
            self.ingredientsList = self.pictureList
            self.receipeTableView.reloadData()

        }
    }
//    func performSegue1(identifier:String){
//        performSegue(withIdentifier: "goToShoppingList", sender: self)
//    }
    //MARK - Add new grocery list or new meal plan
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add \(receipeNamePassed) to grocery list?", message: "", preferredStyle: .alert)
        let actionGrocery = UIAlertAction(title: "Add \(receipeNamePassed) to", style: .default){(action) in
            print("Success!")
            self.performSegue(withIdentifier: "goToShoppingList", sender: self)
        }
        let actionFavorite = UIAlertAction(title: "Add \(receipeNamePassed) to favorites", style: .default){(action) in
            print("Success!")
        }
        alert.addAction(actionFavorite)
        alert.addAction(actionGrocery)
        
        present(alert, animated: true, completion: nil)
    }
}


