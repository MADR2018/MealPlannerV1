//
//  tableViewCellControllerViewController.swift
//  FBApp
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit

class tableViewCellControllerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    let pictureList = ["Broccoli Peas","Canada Pancakes","Creamy Chicken","No-Pain Lo Mein","Peach Cobbler Pancakes","chicken orzo","Rice and Chicken Skillet","Roasted Pork Chops","Spaghetti Squash","Spiced Vegetable Stew"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

   
    // load data with receipes names an images
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        
        cell.image1Text.text = pictureList[indexPath.row]
        
        cell.image1Text.numberOfLines = 3;
        
        cell.foodImage1.image = UIImage(named: pictureList[indexPath.row])
        
        return cell
    }
    
    // pass data at select index
    var selectedIndex: Int = 0
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? tableDetailViewController{
            destination.receipeNamePassed = pictureList[selectedIndex]
        }
    }
    
    

    

}
