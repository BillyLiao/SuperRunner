//
//  RoadTableViewController.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//


import UIKit
import CoreData

class RoadTableViewController: UITableViewController {
    var managedObjectContext: NSManagedObjectContext?
    
    var roadNames = ["星空之路","最大阻力之路","致富之路"]
    var roadInfos = ["就算在台北市,還是有看到星空的權利","在這條路上...你只要跑得比烏龜快一點點就好...","帶你跑遍全台北市中過最多頭彩的彩券行"]
    var roadDistances = ["3km", "5.7km", "1.9km"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 113/255, green: 197/255, blue: 191/255, alpha: 1)

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
        return roadNames.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RoadTableViewCell
        
        // Configure the cell...
        cell.roadName.text = roadNames[indexPath.row]
        cell.RoadImageView.image = UIImage(named: roadNames[indexPath.row])
        
        return cell
    }
    
    @IBAction func close(segue:UIStoryboardSegue){
        
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
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showRoadDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! DetailRoadViewController
                destinationController.managedObjectContext = managedObjectContext
            
                destinationController.roadDistance = roadDistances[indexPath.row]
                destinationController.roadInfo = roadInfos[indexPath.row]
                destinationController.roadName = roadNames[indexPath.row]
            }
        }
    }
    
    
}

