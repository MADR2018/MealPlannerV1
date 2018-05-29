
//
//  favouriteTableViewController.swift
//  
//
//  Created by Administrator on 5/29/18.
//

import UIKit
import Firebase
class favouriteTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    var pictureList = ["Cauliflower Tikka Masala"]
    var favouriteList: [String] = []
    var PassedfavouriteReceipe = ""
    var repeatedReceipe:Bool = false
    var favouriteButtonPress: Bool = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("the result of favourite Button is   " + String(favouriteButtonPress))
        tableView.delegate = self
        tableView.dataSource = self
        //writeFavouriteListToFirebaseForThisUser()
        loadFavouriteListFromFirebaseForThisUser()
        
    }
    @IBOutlet weak var tableView: UITableView!
    //set up table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictureList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell") as! favoriteTableViewCell
        
        cell.favLabel.text = pictureList[indexPath.row]
        
        cell.favLabel.numberOfLines = 4;
        
        cell.favImage.image = UIImage(named: pictureList[indexPath.row])
        return cell
    }
    
    
    func writeFavouriteListToFirebaseForThisUser(){
        let favouriteListDB = Database.database().reference().child("users").child("MH48tjT3KZgulzvrKgBpKj3Qwy22").child("favourites")
        favouriteListDB.setValue(pictureList)
        
        
    }
    func loadFavouriteListFromFirebaseForThisUser(){
        let shoppingListDB = Database.database().reference().child("users").child("MH48tjT3KZgulzvrKgBpKj3Qwy22").child("favourites")
        shoppingListDB.observeSingleEvent(of:.value){(snapshot) in
            let snapshotValue = snapshot.value as! Array<String>
            self.favouriteList = snapshotValue
            //print("load from firebase \(self.favouriteList) ")
            for singleItem in self.favouriteList{
                if(singleItem == self.PassedfavouriteReceipe){
                    self.repeatedReceipe = true
                }
            }
            if self.repeatedReceipe == false && self.PassedfavouriteReceipe != "" && self.favouriteButtonPress == false{
                self.addFavouriteListToFireBaseFavouriteList()
                self.pictureList = self.favouriteList
                self.writeFavouriteListToFirebaseForThisUser()
            }
            self.pictureList = self.favouriteList
            self.tableView.reloadData()
            
            
        }
    }
    func addFavouriteListToFireBaseFavouriteList(){
        
            favouriteList.append(PassedfavouriteReceipe)
        
        //print("after append what is in the firebase \(self.favouriteList) ")
        
    }

    

}
