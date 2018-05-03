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
        if let user = user {
            let uid = user.uid
        }
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child((user?.uid)!)
        let values = ["diet": "Vegetarian"]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in

            if err != nil {
                print(err!)
                return
            }

            print("Saved user successfully")
        })

    }
    
    @IBAction func noLimitPressed(_ sender: UIButton) {
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
        }
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child((user?.uid)!)
        let values = ["diet": "No Limit"]
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            print("Saved user successfully")
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
