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
    @IBOutlet weak var receipeTableView: UITableView!
    
    @IBOutlet weak var selectedFoodImage: UIImageView!
    
    @IBOutlet weak var foodLabel: UILabel!
    
    var receipeNamePassed : String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receipeTableView.delegate = self
        receipeTableView.dataSource = self
        
        foodLabel.text = receipeNamePassed
        selectedFoodImage.image = UIImage(named: receipeNamePassed)
        //get data from firebase
        retrieveMessages()
        
        
//
        
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
        
        let receipeDB = Database.database().reference().child("Recipes").child(receipeNamePassed)
        receipeDB.observe(.value){(snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            var temp = snapshotValue["Ingredients"]!
            print("what is in the temp \(temp)" )
            print(temp.split(separator: "#"))
            var tempArray = temp.split(separator: "#")
            for singleItem in tempArray{
                print(singleItem)
                self.pictureList.append(String(singleItem))
            }
            
            self.receipeTableView.reloadData()
//
        }

    
    
    }
    
}


