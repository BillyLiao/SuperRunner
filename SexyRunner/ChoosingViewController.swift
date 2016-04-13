//
//  ChoosingViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class ChoosingViewController: UIViewController {

    @IBOutlet weak var topic: UIButton!
    @IBOutlet weak var blogConfidential: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)

        topic.imageView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)
        blogConfidential.imageView?.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topic(sender: AnyObject) {
    }
    @IBAction func blogConfidential(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {


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
