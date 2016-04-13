//
//  SideChoosingViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/28.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
class SideChoosingViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
            managedObjectContext = appDelegate.managedObjectContext
        }
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func chooseSide(sender: AnyObject) {
        
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        
        let button = sender as! UIButton
        if button.titleLabel?.text == "共和軍" {
            print("Choose to join republic.")
            user.tribe = "Republic"
            user.tribePhoto = UIImageJPEGRepresentation(UIImage(named: "Republic")!,0.6)!
            
        } else {
            print("Choose to join rebel.")
            user.tribe = "Rebel"
            user.tribePhoto = UIImageJPEGRepresentation(UIImage(named: "Rebel")!, 0.6)!
        }
        
        var err: NSError?
        do {
            try managedObjectContext.save()
            print("Choose side successfully.")
            performSegueWithIdentifier("showWarField", sender: self)
        } catch {
            print(err?.localizedDescription)
        }
        
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
