//
//  findFriendViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class findFriendViewController: UIViewController {

    @IBOutlet weak var findFriendButton: UIButton!
    @IBOutlet weak var dontFindFrientButton: UIButton!
    @IBOutlet weak var headImageView: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        self.dontFindFrientButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        self.findFriendButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
