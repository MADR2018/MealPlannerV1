//
//  favoriteTableViewCell.swift
//  FBApp
//
//  Created by Administrator on 5/29/18.
//  Copyright © 2018 Sophie Amin. All rights reserved.
//

import UIKit

class favoriteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var favImage: UIImageView!
    @IBOutlet weak var favLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
