//
//  SignOutViewController.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-04-23.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignOutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let sections = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let fruit = ["Apple", "Orange", "Mango"]
    
    //Assume one entry each for now
    var monSelection = [String]()
    var tueSelection = [String]()
    var wedSelection = [String]()
    var thuSelection = [String]()
    var friSelection = [String]()
    var satSelection = [String]()
    var sunSelection = [String]()
    
    let vegetables = ["Carrot", "Broccoli", "Cucumber"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref:DatabaseReference!
        ref = Database.database().reference()
        //TODO: load user recipe selections
        let userID = Auth.auth().currentUser?.uid
    ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //get user value
            let value = snapshot.value as? NSDictionary
            let recipeIDs = value?["monSelectionID"] as? String ?? ""
            let selection = recipeIDs
        self.monSelection.append(selection)
        print("***Contents of Monday*** \(self.monSelection)")
        })
        

        
        
        //        guard let email = Auth.auth().currentUser?.email else { return }
        //        label.text = "Hello \(email)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogoutTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
            
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            //Fruit section
            return fruit.count
        case 1:
            //Vegetable section
            return vegetables.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Create an object of the dynamic cell "PlainCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        //Depending on the section, fill the textLabel with the relevant text
        switch indexPath.section {
            case 0:
            //fruit section
            cell.textLabel?.text = fruit[indexPath.row]
            break
        case 1:
            //Vegetable section
            cell.textLabel?.text = vegetables[indexPath.row]
            break
        default:
            break
        }
        return cell
    }
}
