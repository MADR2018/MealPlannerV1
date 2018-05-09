//
//  User.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-03.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation
import Firebase

class CurrentUser {
    
    static let shared = CurrentUser()
    
    private init() {}
    
    let user = Auth.auth().currentUser
//    if let user = user {
//        let uid = user.uid
//    }

    

}
