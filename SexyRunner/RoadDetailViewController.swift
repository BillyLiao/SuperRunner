//
//  RoadDetailViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class RoadDetailViewController: UIViewController {

    @IBOutlet weak var dot1:UIImageView!
    @IBOutlet weak var dot2:UIImageView!
    @IBOutlet weak var runButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        dot1.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        dot2.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
        dot1.layer.cornerRadius = (dot1.frame.size.width) / 2
        dot1.clipsToBounds = true
        
        dot2.layer.cornerRadius = (dot2.frame.size.width) / 2
        dot2.clipsToBounds = true
        
        runButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
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
