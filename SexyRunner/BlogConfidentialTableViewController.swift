//
//  BlogConfidentialTableViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit

class BlogConfidentialTableViewController: UITableViewController {

    var locations = ["Tapei, Neihu", "Taipei, HsinYi", "Taipei, GongGung", "Taipei, DaAn"]
    var follower = ["792","249","184","296"]
    var following = ["12","82","11","28"]
    var profile = ["Alex Dong.jpg","Lydia Liu.jpg","Alice Co.jpg", "Jimmy Wang.jpg"]
    var name = ["Alex Dong","Lydia Liu","Alice Co", "Jimmy Wang"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 140
        tableView.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellidentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellidentifier, forIndexPath: indexPath) as! BlogConfidentialTableViewCell

        // Configure the cell...

        cell.nameLabel?.text = name[indexPath.row]
        cell.locationLabel?.text = locations[indexPath.row]
        cell.followerLabel?.text = follower[indexPath.row]
        cell.followingLabel?.text = following[indexPath.row]
        cell.profileImageView?.image = UIImage(named: profile[indexPath.row])
        cell.profileImageView?.layer.cornerRadius = (cell.profileImageView?.frame.size.width)! / 2
        cell.profileImageView?.clipsToBounds = true
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
