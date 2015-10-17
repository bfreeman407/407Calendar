//
//  EditViewController.swift
//  407Cal
//
//  Created by Ben Freeman on 10/16/15.
//  Copyright © 2015 Ben Freeman. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    var currentEvent : Event?

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBAction func saveEvent(sender: AnyObject) {
        currentEvent?.eventDate = datePicker.date
        currentEvent?.eventTitle = titleTextField.text!
        currentEvent?.eventLocation = locationTextField.text!
        currentEvent?.eventNotes = notesTextField.text!
        
        Calendar.shared.add(currentEvent!)
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        datePicker.date = currentEvent!.eventDate
        
        if self.currentEvent?.eventTitle != "" {
            titleTextField.text = currentEvent?.eventTitle
        }
        
        if self.currentEvent?.eventLocation != "" {
            locationTextField.text = currentEvent?.eventLocation
        }
        
        if self.currentEvent?.eventNotes != "" {
            notesTextField.text = currentEvent?.eventNotes
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
