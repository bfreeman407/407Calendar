//
//  DayTableViewController.swift
//  407Cal
//
//  Created by Ben Freeman on 10/26/15.
//  Copyright © 2015 Ben Freeman. All rights reserved.
//

import UIKit

class DayTableViewController: UITableViewController {
    
    var currentDay = NSDate()
    var currentEvent : Event?
    var daysEvents : [Event]?
    var outgoingDay : NSDate?

    
    @IBOutlet weak var navBarItem: UINavigationItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        daysEvents = Calendar.shared.getDay(currentDay)
        let df = NSDateFormatter()
        df.dateStyle = .ShortStyle
        navBarItem.title = df.stringFromDate(currentDay)
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
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
        return daysEvents!.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daycell", forIndexPath: indexPath)

        // Configure the cell...
        let eventForCurrentRow = daysEvents![indexPath.row]
        cell.textLabel?.text = eventForCurrentRow.eventTitle
        cell.tag = indexPath.row

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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "dayToNext" {
            let nextViewController = segue.destinationViewController as! DayTableViewController
            outgoingDay = currentDay.dateByAddingTimeInterval(86500)
            nextViewController.currentDay = outgoingDay!
        }
        else if segue.identifier == "dayToPrevious" {
            
            let nextViewController = segue.destinationViewController as! DayTableViewController
            outgoingDay = currentDay.dateByAddingTimeInterval(-86500)
            nextViewController.currentDay = outgoingDay!
        }
        else if segue.identifier == "dayToDetail" {
            let nextViewController = segue.destinationViewController as! DetailViewController
            let selectedCell = sender as! UITableViewCell
            self.currentEvent = Calendar.shared.events[selectedCell.tag]
            nextViewController.currentEvent = self.currentEvent
        }
        else if segue.identifier == "dayToEdit" {
            let nextViewController = segue.destinationViewController as! EditViewController
            nextViewController.currentEvent = Event(date: currentDay, title: "", location: "", notes: "")
        }
        
    }


}
