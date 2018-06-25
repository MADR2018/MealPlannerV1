//
//  UserData.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-08.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation
import Firebase

class UserData {
    var email: String = ""
    var password: String = ""
    var diet: String = ""
    //recipe selection for each day will be queried by the recipe id
    var monSelectionID: String = ""
    var tueSelectionID: String = ""
    var wedSelectionID: String = ""
    var thuSelectionID: String = ""
    var friSelectionID: String = ""
    var satSelectionID: String = ""
    var sunSelectionID: String = ""


    init(email: String, password: String, diet: String, monSelectionID: String, tueSelectionID: String, wedSelectionID: String, thuSelectionID: String, friSelectionID: String, satSelectionID: String, sunSelectionID: String){
        self.email = email
        self.password = password
        self.diet = diet
        self.monSelectionID = monSelectionID
        self.tueSelectionID = tueSelectionID
        self.wedSelectionID = wedSelectionID
        self.thuSelectionID = thuSelectionID
        self.friSelectionID = friSelectionID
        self.satSelectionID = satSelectionID
        self.sunSelectionID = sunSelectionID
    }
    
    //save user function for signup
    
    func createAuthUser(email: String, password: String){
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error)  in
            guard error == nil else {
                //TODO: get alerts working in signup view controller
                
                // AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            print(user.email ?? "MISSING EMAIL")
            
            //if there's no email print missing email. this is only a thing if you have an alternative signup method like facebook, etc
            print(user.uid)
            
            //user id will exist regardless if the user exists
            
            //change request is for changing the users profile info
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else{
                    // AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                    return
                    
                }
                DatabaseService.shared.userReference.child(user.uid).updateChildValues(self.toDictionary(), withCompletionBlock: { (err, ref) in
                    
                    if err != nil {
                        print(err!)
                        return
                    }
                    
                    print("Saved user successfully")
                })
            })
        })
    }
    
    
    //convert to an array of dictionaries to pass the user into firebase
    func toDictionary() -> [String : Any]{
        return [
            "email:" : email,
            "password" : password,
            "diet" : diet,
            "monSelectionID" : monSelectionID,
            "tueSelectionID" : tueSelectionID,
            "wedSelectionID" : wedSelectionID,
            "thuSelectionID" : thuSelectionID,
            "friSelectionID" : friSelectionID,
            "satSelectionID" : satSelectionID,
            "sunSelectionID" : sunSelectionID
        ]
    }
}
