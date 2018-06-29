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
    //MEAL DETAILS VIEW CONTROLLER
    var pictureList = [String]()
    var ingredientsList: [String] = []
    var instructionList: [String] = []
    var groceryAlertResult:Bool = false
    var comeFromFavouriteList:Bool = false
    let userID = Auth.auth().currentUser!.uid
    
    
    
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
        retrieveRecipe()
        
        
        
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
    func retrieveRecipe(){
        
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
    
    //MARK - Add new grocery list or new meal plan
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add \(receipeNamePassed) to grocery list or favorites?", message: "", preferredStyle: .alert)
        let actionGrocery = UIAlertAction(title: "Add \(receipeNamePassed) to grocerylist", style: .default){(action) in
            print("Success!")
            self.groceryAlertResult = true
            self.performSegue(withIdentifier: "goToShoppingList", sender: self)
        }
        
        
        if (comeFromFavouriteList == false){
            let actionFavorite = UIAlertAction(title: "Add \(receipeNamePassed) to favorites", style: .default){(action) in
                print("Success!")
                self.loadFavouriteListFromFirebaseForThisUser()
            }
            alert.addAction(actionFavorite)
        }
        
        alert.addAction(actionGrocery)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // pass selected shopping list to shopping list table view controller and pass selected food receipe to favourite receipe list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ShoppingListTableViewController{
            destination.shoppingListReceived = ingredientsList
            destination.groceryAlertPress = groceryAlertResult
        }
        
    }
    
    // Add selected food recipe to Meal Plan
    var alert:UIAlertController? = nil
    @IBAction func addToMealPlan(_ sender: UIBarButtonItem) {
        alert = UIAlertController(title: "Add \(receipeNamePassed) to Meal plans?", message: "", preferredStyle: .alert)
        addToMealPlanMonToSun(selectDay: "Monday",selectDayId : "monSelectionID")
        addToMealPlanMonToSun(selectDay: "Tuesday",selectDayId : "tueSelectionID")
        addToMealPlanMonToSun(selectDay: "Wednesday",selectDayId : "wedSelectionID")
        addToMealPlanMonToSun(selectDay: "Thursday",selectDayId : "thuSelectionID")
        addToMealPlanMonToSun(selectDay: "Friday",selectDayId : "friSelectionID")
        addToMealPlanMonToSun(selectDay: "Saturday",selectDayId : "satSelectionID")
        addToMealPlanMonToSun(selectDay: "Sunday",selectDayId : "sunSelectionID")
        present(alert!, animated: true, completion: nil)
    }
    
    func addToMealPlanMonToSun(selectDay : String, selectDayId : String){
        let actionAddtoMealPlan = UIAlertAction(title: "Add \(receipeNamePassed) to \(selectDay)", style: .default){(action) in
            self.writeMealPlanToFirebaseForThisUser(selectDayIdforFirebase : selectDayId)
        }
        alert?.addAction(actionAddtoMealPlan)
    }
    func writeMealPlanToFirebaseForThisUser(selectDayIdforFirebase : String){
        let mealPlanDB = Database.database().reference().child("users").child(userID).child(selectDayIdforFirebase)
        mealPlanDB.setValue(receipeNamePassed)
    }
    
    
    
    
    
    
    
    // update the favouriteList
    var favouriteList: [String] = []
    var repeatedReceipe:Bool = false
    func writeFavouriteListToFirebaseForThisUser(){
        let favouriteListDB = Database.database().reference().child("users").child(userID).child("favourites")
        favouriteListDB.setValue(favouriteList)
    }
    func loadFavouriteListFromFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child(userID).child("favourites")
        shoppingListDB.observeSingleEvent(of:.value){(snapshot) in
            let snapshotValue = snapshot.value as? Array<String> ?? self.favouriteList
            self.favouriteList = snapshotValue
            print("load from firebase \(self.favouriteList) ")
            for singleItem in self.favouriteList{
                if(singleItem == self.receipeNamePassed){
                    self.repeatedReceipe = true
                }
            }
            if (self.repeatedReceipe == false){
                self.updateFireBaseAndLocalList()
            }
            self.pictureList = self.favouriteList
        }
    }
    func updateFireBaseAndLocalList(){
        addFavouriteListToFireBaseFavouriteList()
        writeFavouriteListToFirebaseForThisUser()
    }
    func addFavouriteListToFireBaseFavouriteList(){
        favouriteList.append(receipeNamePassed)
        //print("after append what is in the firebase \(self.favouriteList) ")
    }
        
    
}



