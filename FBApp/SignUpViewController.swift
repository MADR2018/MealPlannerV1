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
            //TODO take out, from when usernanme was included
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else{
                    AlertController.showAlert(inViewController: self, title: "Error", message: error!.localizedDescription)
                    return
                    
                }
                //                guard let uid = user.uid else {
                //                    return
                //                }
                
                //authenticated user additional info
                //                let ref = Database.database().reference()
                //                let usersReference = ref.child("users").child(user.uid)
                
                let values = ["email": email, "diet": "None"]
                DatabaseService.shared.userReference.child(user.uid).updateChildValues(values, withCompletionBlock: { (err, ref) in
                    
                    if err != nil {
                        print(err!)
                        return
                    }
                    
                    print("Saved user successfully")
                })
                
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                
            })
        })
        
    }
    
}
