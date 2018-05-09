//
//  UserData.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-08.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation
import Firebase

class UserData {
    var uid: String
    var email: String
    var password: String
    var diet: String
    
    
    init(uid: String, email: String, password: String, diet: String){
        self.uid = uid
        self.email = email
        self.password = password
        self.diet = diet
    }
    
    //    func saveUser(){
    //        let dbReference =  Database.database().reference()
    //        let userRef = ref.child("users").child(users.uid)
    //
    //    }
    func toDictionary() -> [String : Any]{
        return [
            "uid" : uid,
            "email:" : email,
            "password" : password,
            "diet" : diet
        ]
    }
}
