//
//  SettingsViewController.swift
//  kaPu
//
//  Created by Emily Tan on 11/30/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var settingsTableView: UITableView!
    
    let ref = Database.database().reference().child("users")
    
    var uid: String!
    var name: String!
    var email: String!
    var mobile: String!
    var childrenNames: [String]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        
        loadData()
    }
    
    func loadData() {
        // Pull user information
        let user = Auth.auth().currentUser
        if let user = user {
            self.uid = user.uid
            self.email = user.email
        }
        
        ref.child(uid).child("name").observe(.value) { (DataSnapshot) in
            // print(DataSnapshot.value as Any)
            self.name = DataSnapshot.value as? String
        }
        
        ref.child(uid).child("mobile").observe(.value) { (DataSnapshot) in
            self.mobile = DataSnapshot.value as? String
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int
        switch (section) {
        case 0:
            count = 3
            break
        case 1:
            count = children.count + 1
            break
        default:
            count = 2
            break
        }
        print(count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                cell.profileInfo.text = self.name
                // print("name is \(self.name!)")
            } else if (indexPath.row == 1) {
                cell.profileInfo.text = self.email
            } else {
                cell.profileInfo.text = self.mobile
                // print("mobile is \(self.mobile!)")
            }
            break
        case 1:
            if (indexPath.row == childrenNames.count) {
                cell.profileInfo.text = "Add Child"
                cell.profileInfo.textAlignment = .center
                cell.profileInfo.textColor = UIColor.orange
            } else {
                cell.profileInfo.text = childrenNames[indexPath.row]
            }
            break
        default:
            if indexPath.row == 0 {
                cell.profileInfo.text = "My Friends"
            } else if indexPath.row == 1 {
                cell.profileInfo.text = "My Locations"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section) {
        case 0:
            break
        case 1:
            if (indexPath.row == children.count) {
                self.performSegue(withIdentifier: "addChildSegue", sender: self)
            }
            tableView.deselectRow(at: indexPath, animated: true)
            break
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header: String!
        switch (section) {
        case (0):
            header = "Profile Info"
        case (1):
            header = "My Kids"
        default:
            header = "Favorites"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 16)!
        header.textLabel?.textColor = UIColor.black
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    @IBAction func logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error: ", signOutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    @IBAction func unwindFromAddChild(_ sender: UIStoryboardSegue) {
        if let addChildViewControllerInstance = sender.source as? AddChildViewController {
            if let kid = addChildViewControllerInstance.kid {
                // update the model in groups and in users
                ref.child(uid).updateChildValues(["kids": kid])
                childrenNames.append(kid)
                print("count + \(childrenNames.count)")
                settingsTableView.reloadData()
            }
        }
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
