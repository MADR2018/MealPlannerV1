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
    var ref:DatabaseReference?
    var handle: DatabaseHandle?
    
    var pictureList = [String]()
    @IBOutlet weak var receipeTableView: UITableView!
    
    @IBOutlet weak var selectedFoodImage: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    var detail:receipeData!
    var receipeNamePassed : String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receipeTableView.delegate = self
        receipeTableView.dataSource = self
        
        foodLabel.text = receipeNamePassed
        selectedFoodImage.image = UIImage(named: receipeNamePassed)
        //get data from firebase
        retrieveMessages()
        print("after temp")
        
//        handle = ref?.child("Recipes").child("Instructions").observe(.value, with: { (snapshot) in
//            if let item = snapshot.value as? String{
//                for a in item{
//                    let b = a.value as? String
//                }
//                self.pictureList.append(item)
//                print("data from firebase is" + item)
//                self.receipeTableView.reloadData()
//                self.ref?.keepSynced(true)
//            }
//
//        })
        
    }
    
    // load the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "receipesCell", for: indexPath)
        cell.textLabel?.text = pictureList[indexPath.row]
        return cell
    }
    func retrieveMessages(){
        
        let receipeDB = Database.database().reference().child("Recipes")
        receipeDB.observe(.childAdded){(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            var temp = snapshotValue["ReceipesName"]!
            print("what is in the temp \(temp)" )
            self.pictureList.append(temp)
            self.receipeTableView.reloadData()
//            receipeDB.child("ReceipesName").observeSingleEvent(of: .value, with: { (snapshot) in
//                // Get user value
//                let value = snapshot.value as? NSDictionary
//                let temp = value?["ReceipesName"] as? String ?? "lalalal"
//                self.pictureList.append(temp)
//                print("what is in the temp \(temp)" )
//                self.receipeTableView.reloadData()
//
//
//        })
        }

    
    
    }
    
}


