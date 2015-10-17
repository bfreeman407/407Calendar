//
//  CalendarModel.swift
//  407Cal
//
//  Created by Ben Freeman on 10/16/15.
//  Copyright © 2015 Ben Freeman. All rights reserved.
//

import Foundation

class Calendar {
    
    static let shared = Calendar()
    
    func populateSampleData(num: Int) {
        for _ in 0...num {
            Calendar.shared.add(Event(date: NSDate(), title: "Sample Title", location: "Sample Location", notes: "Sample Notes"))
        }
    }
    
    
    var nextGUID : Int
    var events : [Event]
    
    init() {
        nextGUID = 0
        events = []
    }
    
    func add(event: Event) {
        //if the event has a non-negative GUID, it is an existing event
        //that has been edited. Remove the old version first.
        if event.eventGUID >= 0 {
            for i in 0...(events.count - 1) {
                if events[i].eventGUID == event.eventGUID {
                    events.removeAtIndex(i)
                    break
                }
            }
        }
        
        //if the event has a negative GUID, it is a new event. Give it
        //a valid GUID.
        if event.eventGUID < 0 {
            event.eventGUID = nextGUID
            nextGUID++
        }
        
        //insert the event chronologically. step through the array
        //looking for the first event with a later date than this one
        //and save the appropriate index for the new event. If no later
        //date is found, the index will (correctly) be the end of the array
        
        var newEventIndex = 0
        if events.count < 0 {
            for i in 0...(events.count - 1) {
                if event.eventDate.compare(events[i].eventDate) == NSComparisonResult.OrderedAscending {
                    break
                }
                newEventIndex++
            }
        }
        //add the new event at the designated index
        events.insert(event, atIndex: newEventIndex)
    }
    
    func remove(guid: Int) {
        //step through the array looking for an event with matching GUID,
        //then remove it
    }
    
}

class Event {
    
    var eventDate : NSDate
    var eventTitle : String
    var eventLocation : String
    var eventNotes : String
    var eventGUID : Int
    
    init(date: NSDate, title: String, location: String, notes: String) {
        eventDate = date
        eventTitle = title
        eventLocation = location
        eventNotes = notes
        eventGUID = -1
    }
    

}

