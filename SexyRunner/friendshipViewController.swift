//
//  friendshipViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class friendshipViewController: UIViewController {

    @IBOutlet weak var startChatButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        startChatButton.backgroundColor = UIColor(red: 234/255, green: 96/255, blue: 95/255, alpha: 1)
        
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startChatButton(sender: AnyObject) {
        
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
