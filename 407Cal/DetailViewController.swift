//
//  DetailViewController.swift
//  407Cal
//
//  Created by Ben Freeman on 10/16/15.
//  Copyright © 2015 Ben Freeman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentEvent : Event?

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)

        
        let df = NSDateFormatter()
        df.timeStyle = .ShortStyle
        df.dateStyle = .ShortStyle
        
        testLabel.text = df.stringFromDate(currentEvent!.eventDate)
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "detailToEdit" {
            let nextViewController = segue.destinationViewController as! EditViewController
            nextViewController.currentEvent = self.currentEvent
        }
    }
}
