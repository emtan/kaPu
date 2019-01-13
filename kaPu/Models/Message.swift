//
//  Message.swift
//  kaPu
//
//  Created by Emily Tan on 12/2/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import SwiftKeychainWrapper

struct Message {
    
    // declare attributes of a Message
    let messageid: String!
    let content: String!
    let date: Date!
    let sender: String!
    let messageRef: DatabaseReference!
    
    // get current user
    var currentUser = KeychainWrapper.standard.string(forKey: "uid")
    
    // initialize
    /*init(sender: String) {
        self.sender = sender
    }
    
    init(messageid: String, messageData: Dictionary<String, AnyObject>) {
        self.messageid = messageid
        
        if let sender = postData["sender"] as? String {
            self.sender = sender
        }
        
        self.messageRef = Database.database().reference().child("sender").child(self.messageid)
    }*/
    
}
