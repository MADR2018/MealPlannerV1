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
    var RecipeName:String = ""//make sure to guard
    let userID = Auth.auth().currentUser!.uid
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.monSelection.append("This recipe 1")
        //        self.monSelection.append("This recipe 2")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        monSelection.removeAll(keepingCapacity: false)
        tueSelection.removeAll(keepingCapacity: false)
        wedSelection.removeAll(keepingCapacity: false)
        thuSelection.removeAll(keepingCapacity: false)
        friSelection.removeAll(keepingCapacity: false)
        satSelection.removeAll(keepingCapacity: false)
        sunSelection.removeAll(keepingCapacity: false)
        
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
        
        let cellIdentifier = "MealPlanTableViewCell"
        //Create an object of the dynamic cell "PlainCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealPlanTableViewCell else {
            fatalError("the dequeued cell is not an instance of MealPlanTableViewCell")
        }
        //Depending on the section, fill the textLabel with the relevant text
        switch indexPath.section {
        case 0:
            //monday section
            cell.mealLabel.text = monSelection[indexPath.row]
            
            break
        case 1:
            //tuesday section
            //cell.textLabel?.text = tueSelection[indexPath.row]
            cell.mealLabel.text = tueSelection[indexPath.row]
            break
        case 2:
            //wednesday section
            cell.mealLabel.text = wedSelection[indexPath.row]
            break
        case 3:
            //thursday section
            cell.mealLabel.text = thuSelection[indexPath.row]
            break
        case 4:
            //friday section
            cell.mealLabel.text = friSelection[indexPath.row]
            break
        case 5:
            //saturday section
            cell.mealLabel.text = satSelection[indexPath.row]
            break
        case 6:
            //sunday section
            cell.mealLabel.text = sunSelection[indexPath.row]
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if editingStyle == .delete {
                // Delete the row from the data source
                monSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "monSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 1:
            if editingStyle == .delete {
                // Delete the row from the data source
                tueSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "tueSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 2:
            if editingStyle == .delete {
                // Delete the row from the data source
                wedSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "wedSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 3:
            if editingStyle == .delete {
                // Delete the row from the data source
                thuSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "thuSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 4:
            if editingStyle == .delete {
                // Delete the row from the data source
                friSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "friSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 5:
            if editingStyle == .delete {
                // Delete the row from the data source
                satSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "satSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        case 6:
            if editingStyle == .delete {
                // Delete the row from the data source
                sunSelection.remove(at: indexPath.row)
                deleteFirebaseDayEntry(dayID: "sunSelectionID")
                //writeFavouriteListToFirebaseForThisUser()
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
            
        default:
            print("default")
            
        }
        
    }
    
    var selectedIndex: Int = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        switch indexPath.section {
        case 0:
                if(!monSelection[0].isEmpty){
                RecipeName = monSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
                }
                else{
                    break
            }
        case 1:
         
            if(!tueSelection[0].isEmpty){
                RecipeName = tueSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }
        case 2:
            if(!wedSelection[0].isEmpty){
                RecipeName = wedSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }
        case 3:
            if(!thuSelection[0].isEmpty){
                RecipeName = thuSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }
        case 4:
            if(!friSelection[0].isEmpty){
                RecipeName = friSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }
        case 5:
            if(!satSelection[0].isEmpty){
                RecipeName = satSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }
        case 6:
            if(!sunSelection[0].isEmpty){
                RecipeName = sunSelection[0]
                performSegue(withIdentifier: "showMealDetails", sender: self)
            }
            else{
                break
            }        default:
            print("wat")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? tableDetailViewController{
            destination.receipeNamePassed = RecipeName
        }
    }
    
    func deleteFirebaseDayEntry(dayID: String){
        let favouriteListDB = Database.database().reference().child("users").child(userID).child(dayID)
        favouriteListDB.setValue(monSelection)
    }
    
}




