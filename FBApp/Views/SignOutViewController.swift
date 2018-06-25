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
    @IBOutlet weak var selectionsTableView: UITableView!
    
    let sections = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    //Assume one entry each for now
    var monSelection = [String]()
    var tueSelection = [String]()
    var wedSelection = [String]()
    var thuSelection = [String]()
    var friSelection = [String]()
    var satSelection = [String]()
    var sunSelection = [String]()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.monSelection.append("This recipe 1")
        //        self.monSelection.append("This recipe 2")
        var ref:DatabaseReference!
        ref = Database.database().reference()
        //TODO: load user recipe selections, and MAKE THIS OOP!
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            //get user value
            let value = snapshot.value as? NSDictionary
            let monRecipeIDs = value?["monSelectionID"] as? String ?? ""
            self.monSelection.append(monRecipeIDs)
            self.selectionsTableView.reloadData()
            
            let tueRecipeIDs = value?["tueSelectionID"] as? String ?? ""
            
            self.tueSelection.append(tueRecipeIDs)
            self.selectionsTableView.reloadData()
            let wedRecipeIDs = value?["wedSelectionID"] as? String ?? ""
            
            self.wedSelection.append(wedRecipeIDs)
            self.selectionsTableView.reloadData()
            let thuRecipeIDs = value?["thuSelectionID"] as? String ?? ""
            
            
            self.thuSelection.append(thuRecipeIDs)
            self.selectionsTableView.reloadData()
            
            let friRecipeIDs = value?["friSelectionID"] as? String ?? ""
            
            self.friSelection.append(friRecipeIDs)
            self.selectionsTableView.reloadData()
            
            let satRecipeIDs = value?["satSelectionID"] as? String ?? ""
            
            self.satSelection.append(satRecipeIDs)
            self.selectionsTableView.reloadData()
            
            let sunRecipeIDs = value?["sunSelectionID"] as? String ?? ""
            
            self.sunSelection.append(sunRecipeIDs)
            self.selectionsTableView.reloadData()
            
            //            self.monSelection.append(monRecipeIDs)
            //            self.tueSelection.append(tueRecipeIDs)
            //            self.wedSelection.append(wedRecipeIDs)
            //            self.thuSelection.append(thuRecipeIDs)
            //            self.friSelection.append(friRecipeIDs)
            //            self.satSelection.append(satRecipeIDs)
            
            print("***Contents of Monday*** \(self.monSelection)")
            //update the tableview HERE
            //self.selectionsTableView.reloadData()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        
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
            return monSelection.count
        case 1:
            return tueSelection.count
        case 2:
            return wedSelection.count
        case 3:
            return thuSelection.count
        case 4:
            return friSelection.count
        case 5:
            return satSelection.count
        case 6:
            return sunSelection.count
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
            //monday section
            cell.textLabel?.text = monSelection[indexPath.row]
            break
        case 1:
            //tuesday section
            cell.textLabel?.text = tueSelection[indexPath.row]
            break
        case 2:
            //wednesday section
            cell.textLabel?.text = wedSelection[indexPath.row]
            break
        case 3:
            //thursday section
            cell.textLabel?.text = thuSelection[indexPath.row]
            break
        case 4:
            //friday section
            cell.textLabel?.text = friSelection[indexPath.row]
            break
        case 5:
            //saturday section
            cell.textLabel?.text = satSelection[indexPath.row]
            break
        case 6:
            //sunday section
            cell.textLabel?.text = sunSelection[indexPath.row]
            break
        default:
            break
        }
        return cell
    }
}



func getRecipeSnapshot(ref: DatabaseReference!, child:String){
    //    ref.child("Recipes").child(child).observeSingleEvent(of: .value, with: { (snapshot) in
    //        //get user value
    //        let value = snapshot.value as? NSDictionary
    //        let recipeName = value?["ReceipesName"] as? String ?? ""
    //        self.monSelection.append(recipeName)
    //        selectionsTableView.reloadData()
    //    })
}
