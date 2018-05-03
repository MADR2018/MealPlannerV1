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
        
        
//        let ref = Database.database().reference()
//        let usersReference = ref.child("users").child(user.uid)
//        let values = ["diet": "Veggie"]
//        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
//            
//            if err != nil {
//                print(err!)
//                return
//            }
//            
//            print("Saved user successfully")
//        })
//        let userDiet = [
//            "diet" : Vegetarian]
//        let ref = FIRDatabase.database().reference()
//        ref.child('users').child(authData!.uid)
        //let userRef = Database.database().reference()
        // userRef.child("users").setValue("Vegetarian")
//        
//        
        
    }
    
    @IBAction func noLimitPressed(_ sender: UIButton) {
        let userRef = Database.database().reference()
        userRef.child("users").setValue("No Limit")
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
