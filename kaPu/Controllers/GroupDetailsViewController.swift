//
//  GroupDetailsViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/6/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class GroupDetailsViewController: UIViewController {
    
    var membersInGroup: [String]! = []
    var kidsInGroup: [String]! = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
