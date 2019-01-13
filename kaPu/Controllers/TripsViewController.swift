//
//  TripsViewController.swift
//  kaPu
//
//  Created by Emily Tan on 11/30/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import MapKit
import Foundation
import Firebase
import FirebaseDatabase

class TripsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    let ref = Database.database().reference()
    var items: [Trip] = []
    var drives: [Trip] = []
    var completed: [Trip] = []
    var rides: [Trip] = []
    var curruserName: String!
    var kids: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref.child("users").child(Auth.auth().currentUser!.uid).child("name").observe(.value) { (DataSnapshot) in
            if let item = DataSnapshot.value as? String {
                self.curruserName = item
            }
        }
        
        /*ref.child("users").child(Auth.auth().currentUser!.uid).child("kids").observe(.value) { (DataSnapshot) in
            if let item = DataSnapshot.value as? [String] {
                self.kids = item
            }
        }*/
    
        ref.child("trips").observe(.value) { (DataSnapshot) in
            print(DataSnapshot.value as Any)
            
            var newTrips: [Trip] = []
            //var completedTrips: [Trip] = []
            for child in DataSnapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let trip = Trip(snapshot: snapshot) {
                        newTrips.append(trip)
                    if (trip.completed) {
                        self.completed.append(trip)
                    } else if (trip.driver == self.curruserName) {
                        self.drives.append(trip)
                    }
                }
            }
            
            self.items = newTrips
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addTrip(_ sender: Any) {
        self.performSegue(withIdentifier: "addNewTripSegue", sender: self)
    }
    
    @IBAction func segControl(_ sender: Any) {
       tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segControl.selectedSegmentIndex == 0 {
            print(drives.count)
            print("here 0!")
            return drives.count
        } else if segControl.selectedSegmentIndex == 1 {
            print(completed.count)
            print("here 1!")
            return completed.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tripsCell = tableView.dequeueReusableCell(withIdentifier: "TripTableViewCell", for: indexPath) as! TripTableViewCell
        
        var tripItem: Trip?
        if segControl.selectedSegmentIndex == 0 {
            tripItem = drives[indexPath.row]
        } else if segControl.selectedSegmentIndex == 1 {
            tripItem = completed[indexPath.row]
        }
        
        tripsCell.groupnameLabel.text = tripItem?.tripName
        var time = tripItem?.tripTime.split(separator: " ")
        tripsCell.dateLabel.text = String((time?[0])!)
        tripsCell.timeLabel.text = String((time?[1])! + time![2])
        tripsCell.locationLabel.text = tripItem?.pickupLoc
        
        return tripsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (segControl.selectedSegmentIndex == 0) {
            self.performSegue(withIdentifier: "selectKidsSegue", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBAction func unwindAddTrip(_ sender: UIStoryboardSegue) {
        if let addTripViewControllerInstance = sender.source as? NewTripViewController {
            if let trip = addTripViewControllerInstance.trip {
                // update the model
                let tripRef = self.ref.child("trips")
                let tripNameRef = tripRef.child(trip.tripName)
                tripNameRef.setValue(trip.toAnyObject())
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectKidsSegue" {
            let selectedTrip = items[(tableView.indexPathForSelectedRow?.row)!]
            let tripDet = segue.destination as! StartTripViewController
            tripDet.trip = selectedTrip
        }
    }

}
