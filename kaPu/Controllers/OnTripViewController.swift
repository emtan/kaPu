//
//  OnTripViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/6/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class OnTripViewController: UIViewController, CLLocationManagerDelegate, UIPopoverPresentationControllerDelegate, MKMapViewDelegate {

    @IBOutlet weak var endTripButton: UIBarButtonItem!
    @IBOutlet weak var kidsBarButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    var trip: Trip!

    let locationManager = CLLocationManager()
    let regionInMeters: Double = 500
    var ref = Database.database().reference()
    var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        mapView.showsUserLocation = true
        checkLocationServices()
        startTime = Date()
        print(startTime)
    }
    
    @IBAction func endTripAction(_ sender: Any) {
        print("stopping trip")
        let alertController = UIAlertController(title: "End trip?", message: "Are you done with the trip?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "End Trip", style: .default, handler: { _ in
            // stop the timestamp, complete trip, stop location updating and get location
            self.locationManager.stopUpdatingLocation()
            self.trip.ref?.updateChildValues(["completed": true])
            let startTimeString = "\(self.startTime)"
            let endTime = Date()
            let endTimeString = "\(endTime)"
            print(endTimeString)
            let alertControllerUpdate = UIAlertController(title: "Trip Info", message: "Start time: " + startTimeString + "\n" + "End time: " + endTimeString, preferredStyle: .actionSheet)
            alertControllerUpdate.addAction(UIAlertAction(title: "Done", style: .cancel))
            self.present(alertControllerUpdate, animated: true)
        }))
        present(alertController, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations {
            print("\(index): \(currentLocation)")
        }
    }
    
    /*@IBAction func checkKidsAction(_ sender: Any) {
        let popoverVC = storyboard?.instantiateViewController(withIdentifier: "popoverController") as! KidsCheckoffViewController
        popoverVC.preferredContentSize = CGSize(width: 20, height: UIScreen.main.bounds.height)
        
        let popover = popoverPresentationController
        popover?.delegate = self
        popover?.barButtonItem = sender as? UIBarButtonItem
        self.present(popoverVC, animated: true)
    }*/
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
        } else {
            let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable Location Services to use this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            let alert = UIAlertController(title: "App Denied Access", message: "Please enable Location Services to use this app", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in let url = URL(string: UIApplication.openSettingsURLString)!
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            let alert = UIAlertController(title: "Sorry", message: "This app is restricted from use", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            break
        case .authorizedAlways:
            break
        }
    }
}

extension ViewController: CLLocationManagerDelegate, MKMapViewDelegate {

}
