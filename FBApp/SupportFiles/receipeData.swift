//
//  receipeData.swift
//  FBApp
//
//  Created by Administrator on 5/21/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//
import UIKit
import Foundation
class receipeData{
    var name: String
    var imageName: UIImage
    init(name: String){
        self.name = name
        imageName = UIImage(named: self.name)!
    }
    
    
    
}
