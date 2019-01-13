//
//  Channels.swift
//  kaPu
//
//  Created by Emily Tan on 12/2/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

struct Channel {
    
    // instantiate properties of a Channel
    let channelName: String!
    let channelMembers: [String]!
    
    let ref: DatabaseReference?
    
    // initialize a Channel
    init(channelName: String, channelMembers: [String]) {
        self.ref = nil
        self.channelName = channelName
        self.channelMembers = channelMembers
    }
    
}

