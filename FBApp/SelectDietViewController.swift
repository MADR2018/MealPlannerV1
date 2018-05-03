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

class SelectDietViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func veggiePressed(_ sender: UIButton) {
        
//        let userDiet = [
//            "diet" : Vegetarian]
//        let ref = FIRDatabase.database().reference()
//        ref.child('users').child(authData!.uid)
//        
//        
        
    }
    
    @IBAction func noLimitPressed(_ sender: UIButton) {
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
