//
//  StartTripViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/6/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
import GeoFire
import CoreLocation

class StartTripViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var goButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var trip: Trip!
    var items: [String] = []
    
    let ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        // query database for kids in the group
        tableView.delegate = self
        tableView.dataSource = self
        let group = trip.tripGroup
        ref.child("groups").child(group!).child("kids").observe(.value, with: { (DataSnapshot) in
                //print(DataSnapshot.value)
                var kids: [String] = []
                for child in DataSnapshot.children {
                    if let snapshot = child as? DataSnapshot,
                        let kid = snapshot.value as? String {
                        //print(kid)
                        kids.append(kid)
                    }
                }
                self.items = kids
                self.tableView.reloadData()
            })
    }
    
    @IBAction func goAction(_ sender: Any) {
        self.performSegue(withIdentifier: "beginTripSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectKidsTableViewCell", for: indexPath) as! SelectKidsTableViewCell
        cell.nameLabel.text = items[indexPath.row]
        if (!cell.checked) {
            cell.checkBox.image = UIImage(named: "checkbox-circle.png")
        } else {
            cell.checkBox.image = UIImage(named: "checked-circle.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as! SelectKidsTableViewCell
        selectedCell.checked = !selectedCell.checked
        if (!selectedCell.checked) {
            selectedCell.checkBox.image = UIImage(named: "checkbox-circle.png")
        } else {
            selectedCell.checkBox.image = UIImage(named: "checked-circle.png")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "beginTripSegue" {
            let ontripVC = segue.destination as! OnTripViewController
            ontripVC.trip = self.trip
        }
    }

}
