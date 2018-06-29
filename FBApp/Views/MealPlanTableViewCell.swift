//
//  MealPlanTableViewCell.swift
//  FBApp
//
//  Created by Sophie Amin on 2018-06-28.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit

class MealPlanTableViewCell: UITableViewCell {
    //MARK: Properties
    //@IBOutlet weak var mealImageView: UIImageView?
    @IBOutlet weak var mealLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
