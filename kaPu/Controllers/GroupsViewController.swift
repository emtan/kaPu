//
//  GroupsViewController.swift
//  kaPu
//
//  Created by Emily Tan on 11/30/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addGroupsButton: UIBarButtonItem!
    @IBOutlet weak var searchGroupsBar: UISearchBar!
    @IBOutlet weak var groupsTableView: UITableView!
    
    let ref = Database.database().reference()
    var items: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        groupsTableView.dataSource = self
        groupsTableView.delegate = self
        
        ref.child("groups").observe(.value) { (DataSnapshot) in
            print(DataSnapshot.value as Any)
            
            var newGroups: [Group] = []
            for child in DataSnapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let group = Group(snapshot: snapshot) {
                    newGroups.append(group)
                }
            }
            
            self.items = newGroups
            self.groupsTableView.reloadData()
        }
    }
    
    @IBAction func addGroupAction(_ sender: Any) {
        self.performSegue(withIdentifier: "addNewGroupSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let groupCell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
        let groupItem = items[indexPath.row]
        
        groupCell.groupNameLabel.text = groupItem.groupName
        groupCell.numberKidsLabel.text = "\(groupItem.groupKids.count)" + " kids"
        
        return groupCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showGroupDetailsSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func unwindFromAddGroup(_ sender: UIStoryboardSegue) {
        if let addGroupViewControllerInstance = sender.source as? NewGroupViewController {
            if let group = addGroupViewControllerInstance.group {
                // update the model
                let groupRef = self.ref.child("groups")
                let groupNameRef = groupRef.child(group.groupName)
                groupNameRef.setValue(group.toAnyObject())
                
                let userRef = self.ref.child((Auth.auth().currentUser?.uid)!)
                userRef.updateChildValues(["groups": group.groupName])
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "showGroupDetailsSegue" {
            let selectedGroup = items[(groupsTableView.indexPathForSelectedRow?.row)!]
            let groupDet = segue.destination as! GroupDetailsViewController
            groupDet.navigationItem.title = selectedGroup.groupName
        }
    }

}
