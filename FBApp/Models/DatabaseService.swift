//
//  DatabaseService.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-03.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService() //Singleton
    private init() {}
    
    //create a user reference to store the data in the "users" path
    let userReference = Database.database().reference().child("users")
    
}
