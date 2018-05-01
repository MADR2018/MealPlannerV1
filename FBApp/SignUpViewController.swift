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



class SignUpViewController: UIViewController {

    //MARK: Properties

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //MARK: Actioms
    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let email = emailTF.text,
        email != "",
        let password = passwordTF.text,
        password != ""
        else {
            AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error)  in
            guard error == nil else {
                AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            print(user.email ?? "MISSING EMAIL") //if there's no email print missing email. this is only a thing if you have an alternative signup method like facebook, etc
            print(user.uid) //user id will exist regardless if the user exists
            
            //change request is for changing the users profile info
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else{
                    AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                    return
                    
                }
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                
            })
        })
       
    }
    
}
