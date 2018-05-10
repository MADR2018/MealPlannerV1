//
//  SignOutViewController.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-04-23.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignOutViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else { return }
        label.text = "Hello \(email)"
        // Do any additional setup after loading the view.
    }

    @IBAction func onSignOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
            
        } catch {
            print(error)
        }
    }
    


}
