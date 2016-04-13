//
//  WarFieldTableViewCell.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/4/4.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class WarFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var warFieldPhoto: UIImageView!
    @IBOutlet weak var warFieldName: UILabel!
    @IBOutlet weak var occupantName: UILabel!
    @IBOutlet weak var userRanking: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
