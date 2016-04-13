//
//  BlogConfidentialTableViewCell.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class BlogConfidentialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var locationLabel: UILabel?
    @IBOutlet weak var followButton: UIButton?
    @IBOutlet weak var followerLabel: UILabel?
    @IBOutlet weak var followingLabel: UILabel?
    @IBOutlet weak var profileImageView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        followButton?.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
