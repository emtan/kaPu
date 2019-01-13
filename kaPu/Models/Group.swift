//
//  Group.swift
//  kaPu
//
//  Created by Emily Tan on 12/3/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Group {
    
    // instantiate properties of a group
    let groupName: String!
    let groupMembers: [String]!
    let groupKids: [String]!
    let groupTrips: [Trip]?
    
    let ref: DatabaseReference?
    
    // initalize a Group
    init(groupName: String, groupMembers: [String], groupKids: [String], groupTrips: [Trip]) {
        self.ref = nil
        self.groupName = groupName
        self.groupKids = groupKids
        self.groupTrips = groupTrips
        self.groupMembers = groupMembers
    }
    
    init(groupName: String, groupMembers: [String], groupKids: [String]) {
        self.ref = nil
        self.groupName = groupName
        self.groupKids = groupKids
        self.groupMembers = groupMembers
        self.groupTrips = []
    }
    
    // initialize a Group from a database pull
    init?(snapshot: DataSnapshot) {
        guard
        let value = snapshot.value as? [String: AnyObject],
        let groupName = value["name"] as? String,
        let groupKids = value["kids"] as? [String],
        let groupTrips = value["groupTrips"] as? [Trip]?,
        let groupMembers = value["members"] as?
            [String] else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.groupName = groupName
        self.groupMembers = groupMembers
        self.groupKids = groupKids
        self.groupTrips = groupTrips
    }
    
    // turn group into a dictionary
    func toAnyObject() -> Any {
        return [
            "name": groupName,
            "members": groupMembers,
            "kids": groupKids
        ]
    }
}
