//
//  Trip.swift
//  kaPu
//
//  Created by Emily Tan on 12/3/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Trip {
    
    // instantiate properties of a trip
    let tripName: String!
    let tripTime: String!
    let pickupLoc: String!
    let dropoffLoc: String!
    let tripGroup: String!
    let driver: String!
    let completed: Bool
    
    let ref: DatabaseReference?
    
    // initialize Trip
    init(tripName: String, tripTime: String, pickupLoc: String, dropoffLoc: String, complete: Bool, driver: String, tripGroup: String) {
        self.ref = nil
        self.tripName = tripName
        self.tripTime = tripTime
        self.pickupLoc = pickupLoc
        self.dropoffLoc = dropoffLoc
        self.tripGroup = tripGroup
        self.driver = driver
        self.completed = false
    }
    
    // function to initialize Trip from database snapshot
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let tripName = value["name"] as? String,
            let tripTime = value["time"] as? String,
            let pickupLoc = value["pickup"] as? String,
            let dropoffLoc = value["dropoff"] as? String,
            let completed = value["completed"] as? Bool,
            let driver = value["driver"] as? String,
            let tripGroup = value["trip group"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.tripName = tripName
        self.tripTime = tripTime
        self.pickupLoc = pickupLoc
        self.dropoffLoc = dropoffLoc
        self.tripGroup = tripGroup
        self.driver = driver
        self.completed = completed
    }
    
    // function to turn Trip into dictionary
    func toAnyObject() -> Any {
        return [
            "name": tripName,
            "time": tripTime,
            "pickup": pickupLoc,
            "dropoff": dropoffLoc,
            "completed": completed,
            "driver": driver,
            "trip group": tripGroup
        ]
    }
}
