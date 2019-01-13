//
//  User.swift
//  kaPu
//
//  Created by Emily Tan on 12/7/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Firebase

struct User {
    
    let userName: String!
    let email: String!
    let mobile: String!
    let groupids: [String]!
    let children: [String]!
    
    let ref: DatabaseReference?
    
    init(userName: String, email: String, mobile: String, groupids: [String], children: [String]) {
        self.ref = nil
        self.userName = userName
        self.email = email
        self.mobile = mobile
        self.groupids = groupids
        self.children = children
    }
    
    /*init(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as?
        else {
            return nil
        }
    }*/
}
