//
//  ShoppingListTableViewController.swift
//  FBApp
//
//  Created by Administrator on 5/23/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase

class ShoppingListTableViewController: UITableViewController, UISearchBarDelegate {
    var shoppingListReceived : [String] = []
    var FireBaseShoppingList :  [String] = []
    
    var repeatedShoppingList: Bool = false
    var groceryButtonPress: Bool = false
    var groceryAlertPress: Bool = false
    var emptyShoppingList = ["No Grocery list has been added yet"]
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FireBaseShoppingList = [""]
        //writeShoppingListToFirebaseForThisUser()
        loadShoppingListFromFirebaseForThisUser()
        setUPSearchBar()
        
    }
    func addShoppingListToFireBaseShoppingList(){
        for singleItem in shoppingListReceived{
            FireBaseShoppingList.append(String(singleItem))
        }
        //print("after append what is in the firebase \(self.FireBaseShoppingList) ")
        
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FireBaseShoppingList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath)
        cell.textLabel?.text = String(indexPath.row) + ".   " + FireBaseShoppingList[indexPath.row]
        cell.textLabel?.textColor = UIColor.blue
        cell.textLabel?.numberOfLines = 10;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        return cell
    }
    
    // write and load data from firebase
    
    func writeShoppingListToFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child(userID).child("shoppingList")
        shoppingListDB.setValue(FireBaseShoppingList)
        //shoppingListDB.setValue(shoppingListReceived)
        
    }
    
    func loadShoppingListFromFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child(userID).child("shoppingList")
        shoppingListDB.observeSingleEvent(of:.value){(snapshot) in
            let snapshotValue = snapshot.value as? Array<String> ?? self.emptyShoppingList
            self.FireBaseShoppingList = snapshotValue
            //            for singleItem in self.FireBaseShoppingList{
            //                if self.groceryButtonPress == false{
            //                    if(singleItem == self.shoppingListReceived[0]){
            //                        self.repeatedShoppingList = true
            //                    }
            //                }
            //            }
            if self.repeatedShoppingList == false && self.groceryAlertPress == true{
                if self.FireBaseShoppingList[0] == self.emptyShoppingList[0]{
                    self.FireBaseShoppingList.remove(at: 0)
                }
                self.addShoppingListToFireBaseShoppingList()
                self.writeShoppingListToFirebaseForThisUser()
            }
            self.searchFilteredShoppingList = self.FireBaseShoppingList
            self.tableView.reloadData()
            
            
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    //Swipe to delete a tableview cell
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            FireBaseShoppingList.remove(at: indexPath.row)
            writeShoppingListToFirebaseForThisUser()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
    
    //added UI Search Bar
    var searchFilteredShoppingList :  [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    private func setUPSearchBar(){
        searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        FireBaseShoppingList = searchFilteredShoppingList.filter({ (wantedToSearch) -> Bool in
            wantedToSearch.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        if searchBar.text?.count == 0{
            FireBaseShoppingList = searchFilteredShoppingList
            tableView.reloadData()
        }
        
    }
    
    
    
    
}
