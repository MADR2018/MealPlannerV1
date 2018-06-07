//
//  DailySelections.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-05-28.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation

struct DailySelections{
    //model for the week
    
    var uid: String = ""
    var monSelectionID: String = ""
    var tueSelectionID: String = ""
    var wedSelectionID: String = ""
    var thuSelectionID: String = ""
    var friSelectionID: String = ""
    var satSelectionID: String = ""
    var sunSelectionID: String = ""
    
    init?(uid: String, dict: [String: Any]){
        self.uid = uid
        guard let monSelectionID = dict["monSelectionID"] as? String,
        let tueSelectionID = dict["tueSelectionID"] as? String,
        let wedSelectionID = dict["wedSelectionID"] as? String,
        let thuSelectionID = dict["thuSelectionID"] as? String,
        let friSelectionID = dict["friSelectionID"] as? String,
        let satSelectionID = dict["satSelectionID"] as? String,
        let sunSelectionID = dict["sunSelectionID"] as? String
            else { return nil }
        self.monSelectionID = monSelectionID
        self.tueSelectionID = tueSelectionID
        self.wedSelectionID = wedSelectionID
        self.thuSelectionID = thuSelectionID
        self.friSelectionID = friSelectionID
        self.satSelectionID = satSelectionID
        self.sunSelectionID = sunSelectionID
        
    }
}
