//
//  TripDetailsViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/6/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class TripDetailsViewController: UIViewController {
    @IBOutlet weak var startTripButton: UIBarButtonItem!
    
    var trip: Trip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startTripAction(_ sender: Any) {
        self.performSegue(withIdentifier: "selectKidsSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "selectKidsSegue" {
            let startVC = segue.destination as! StartTripViewController
            startVC.trip = self.trip
        }
    }

}
