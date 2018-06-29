//
//  tableViewCellControllerViewController.swift
//  FBApp
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit

class tableViewCellControllerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
   
    //TABLE VIEW CONTROLLER CLASS
    @IBOutlet weak var tableView: UITableView!
    
    var pictureList = ["Cauliflower Tikka Masala","No-Pain Lo Mein","One-Pot Farfalle Primavera","One-Pot Spaghetti with Fresh Tomato Sauce","Pan Roasted Pork Chops and Broccoli","Pea and Goat's Cheese Risotto","Creamy Chicken and Mushroom One-Pot with Pot Pie Toppers","Aromatic Steamed Mussels","One Skillet Trout with Green Beans","Pot Steamed Salmon"]
    var groceryButton1Result: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchFilteredReceipeList = pictureList
        setUPSearchBar()
        
    }
    
    @IBAction func groceryButtonList(_ sender: Any) {
        groceryButton1Result = true
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
        
        cell.image1Text.numberOfLines = 4;
        
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
    
    
    
    
    
    // added a UI search Bar
    var searchFilteredReceipeList :  [String] = []
    @IBOutlet weak var searchBar: UISearchBar!
    
    private func setUPSearchBar(){
        searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pictureList = searchFilteredReceipeList.filter({ (wantedToSearch) -> Bool in
            wantedToSearch.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
        if searchBar.text?.count == 0{
            pictureList = searchFilteredReceipeList
            tableView.reloadData()
        }
        
    }
    

}
