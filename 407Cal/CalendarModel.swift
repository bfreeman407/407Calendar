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
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    
    //TESTING CODE!!!
    func populateSampleData(num: Int) {
        for _ in 0...(num - 1) {
            Calendar.shared.add(Event(date: NSDate(), title: "Sample Title", location: "Sample Location", notes: "Sample Notes"))
        }
    }
    //TESTING CODE!!!
    
    func restoreSavedData() {
        
        if defaults.arrayForKey("savedDates") == nil {
            return
        }
        
        let savedDates = defaults.arrayForKey("savedDates")as! [NSDate]?
        let savedTitles = defaults.arrayForKey("savedTitles") as! [String]?
        let savedLocations = defaults.arrayForKey("savedLocations") as! [String]?
        let savedNotes = defaults.arrayForKey("savedNotes") as! [String]?
        
        assert(savedDates!.count == savedTitles!.count && savedTitles!.count == savedLocations!.count
            && savedLocations!.count == savedNotes!.count)
        
        for i in 0...(savedDates!.count - 1) {
            Calendar.shared.add(Event(date: savedDates![i], title: savedTitles![i], location: savedLocations![i], notes: savedNotes![i]))
        }
        
    }
    
    private func updateSavedData() {
        
        if events.count <= 0 {
            defaults.removeObjectForKey("savedDates")
            defaults.removeObjectForKey("savedTitles")
            defaults.removeObjectForKey("savedLocations")
            defaults.removeObjectForKey("savedNotes")
            return
        }
        
        var savedDates = [NSDate]()
        var savedTitles = [String]()
        var savedLocations = [String]()
        var savedNotes = [String]()
        
        for i in 0...(events.count - 1) {
            savedDates.insert(events[i].eventDate, atIndex: i)
            savedTitles.insert(events[i].eventTitle, atIndex: i)
            savedLocations.insert(events[i].eventLocation, atIndex: i)
            savedNotes.insert(events[i].eventNotes, atIndex: i)
        }
        
        defaults.setObject(savedDates, forKey: "savedDates")
        defaults.setObject(savedTitles, forKey: "savedTitles")
        defaults.setObject(savedLocations, forKey: "savedLocations")
        defaults.setObject(savedNotes, forKey: "savedNotes")
    }
    
    private var nextGUID : Int
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
        if events.count > 0 {

            for i in 0...(events.count - 1) {
                if event.eventDate.compare(events[i].eventDate) == NSComparisonResult.OrderedAscending {
                    break
                }
                newEventIndex++
            }
        }
        //add the new event at the designated index
        events.insert(event, atIndex: newEventIndex)
        
        //store the updated data persistently
        self.updateSavedData()
    }
    
    func remove(e : Event) {
        //step through the array looking for an event with matching GUID,
        //then remove it
        for i in 0...(events.count - 1) {
            if events[i].eventGUID == e.eventGUID {
                events.removeAtIndex(i)
                break;
            }
        }
        
        self.updateSavedData()
    }
    
    func getDay(date : NSDate) -> [Event]{
        var daysEvents = [Event]()
        for e in events {
            if e.eventDate.compare(date) == NSComparisonResult.OrderedSame {
                daysEvents.append(e)
            }
        }
        
        return daysEvents
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

