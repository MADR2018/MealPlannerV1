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
        
        let user = Auth.auth().currentUser
        //        if let user = user {
        //            let uid = user.uid
        //        }
        // DatabaseService.shared.userReference.child((user?.uid)!)
        let diet = ["diet": "Vegetarian"]
        DatabaseService.shared.userReference.child((user?.uid)!).updateChildValues(diet, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            print("Saved diet successfully")
        })
        
    }
    
    @IBAction func noLimitPressed(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
        }

        let diet = ["diet": "No Limit"]
        DatabaseService.shared.userReference.child((user?.uid)!).updateChildValues(diet, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }

            print("Saved diet successfully")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
