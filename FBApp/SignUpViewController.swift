//
//  SignUpViewController.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-04-23.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    //MARK: Actioms
    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let username = usernameTF.text,
        username != "",
        let email = emailTF.text,
        email != "",
        let password = passwordTF.text,
        password != ""
        else {
            AlertController.showAlert(inViewController: self, title: "Missing Info", message: "Please fill out all fields")
            return
        }
       
    }
    
}
