//
//  SignUpViewController.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-04-23.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseDatabase



class SignUpViewController: UIViewController {
    
    //MARK: Properties
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //MARK: Actions
    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let email = emailTF.text,
            email != "",
            let password = passwordTF.text,
            password != ""
            else {
                AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
                return
        }
        //Create a user object
        let userData = UserData(email: email, password: password, diet: "none", monSelectionID: "none", tueSelectionID: "none", wedSelectionID: "none", thuSelectionID: "none", friSelectionID: "none", satSelectionID: "none", sunSelectionID: "none")
        
        //Save an Authenticated user and save to the database
        userData.createAuthUser(email: email, password: password)
        
        //TODO: send the user object to the next segue?
        self.performSegue(withIdentifier: "signUpSegue", sender: nil)
    }
    
}
