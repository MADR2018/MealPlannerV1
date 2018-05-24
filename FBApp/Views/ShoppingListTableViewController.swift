//
//  ShoppingListTableViewController.swift
//  FBApp
//
//  Created by Administrator on 5/23/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase

class ShoppingListTableViewController: UITableViewController {
    var shoppingListReceived : [String] = []
    var FireBaseShoppingList :  [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadShoppingListFromFirebaseForThisUser()
        
    }
    func addShoppingListToFireBaseShoppingList(){
        for singleItem in shoppingListReceived{
            FireBaseShoppingList.append(String(singleItem))
        }
        print("after append what is in the firebase \(self.FireBaseShoppingList) ")
   
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListReceived.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingListCell", for: indexPath)
        cell.textLabel?.text = shoppingListReceived[indexPath.row]
        cell.textLabel?.numberOfLines = 10;
        cell.textLabel?.lineBreakMode = .byWordWrapping;
        return cell
    }
    
    func writeShoppingListToFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child("MH48tjT3KZgulzvrKgBpKj3Qwy22").child("shoppingList")
        shoppingListDB.setValue(FireBaseShoppingList)

    }
    func loadShoppingListFromFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child("MH48tjT3KZgulzvrKgBpKj3Qwy22").child("shoppingList")
        shoppingListDB.observeSingleEvent(of:.value){(snapshot) in
            let snapshotValue = snapshot.value as! Array<String>
            self.FireBaseShoppingList = snapshotValue
            print("load from firebase \(self.FireBaseShoppingList) ")
            self.addShoppingListToFireBaseShoppingList()
            self.writeShoppingListToFirebaseForThisUser()
        

        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

   
 
 

}
