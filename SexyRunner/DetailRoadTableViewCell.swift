//
//  DetailRoadTableViewCell.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class DetailRoadTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fieldLabel: UILabel?
    @IBOutlet weak var valueLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)

    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
