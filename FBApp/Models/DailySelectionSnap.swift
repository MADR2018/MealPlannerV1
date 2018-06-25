//
//  DailySelectionSnap.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-06-07.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import Foundation
import Firebase

struct DailySelectionsSnap{
    
    let dailySelections: [DailySelections]
    
    init?(with snapshot: DataSnapshot){
        var dailySelections = [DailySelections]()
        guard let snapDict = snapshot.value as? [String: [String: Any]] else { return nil }
        for snap in snapDict {
            guard let dailySelection = DailySelections(uid: snap.key, dict: snap.value) else { continue }
            dailySelections.append(dailySelection)
        }
        self.dailySelections = dailySelections
    }
    
}
