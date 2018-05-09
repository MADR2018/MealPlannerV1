//
//  SelectDietViewController.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-03.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SelectDietViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func veggiePressed(_ sender: UIButton) {
        
        let diet = ["diet": "Vegetarian"]
        DatabaseService.shared.userReference.child((CurrentUser.shared.user!.uid)).updateChildValues(diet, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            print("Saved diet successfully")
        })
        
    }
    
    @IBAction func noLimitPressed(_ sender: UIButton) {
            let diet = ["diet": "No Limit"]
        DatabaseService.shared.userReference.child((CurrentUser.shared.user!.uid)).updateChildValues(diet, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }

            print("Saved diet successfully")
        })
    }
    
    
}
