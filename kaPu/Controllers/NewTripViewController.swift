//
//  NewTripViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/1/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class NewTripViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tripNameTextField: UITextField!
    @IBOutlet weak var tripDateTimeLabel: UILabel!
    @IBOutlet weak var pickupLocationTextField: UITextField!
    @IBOutlet weak var dropOffLocationTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    @IBOutlet weak var tripDatePicker: UIDatePicker!
    @IBOutlet weak var saveNewTripButton: UIBarButtonItem!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var addDriverTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var trip: Trip?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // make UI changes
        tripNameTextField.useUnderline()
        pickupLocationTextField.useUnderline()
        dropOffLocationTextField.useUnderline()
        groupNameTextField.useUnderline()
        groupTextField.useUnderline()
        addDriverTextField.useUnderline()
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        let strDate = dateFormatter.string(from: tripDatePicker.date)
        tripDateTimeLabel.text = strDate
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.trip = Trip(tripName: tripNameTextField.text!, tripTime: tripDateTimeLabel.text!, pickupLoc: pickupLocationTextField.text!, dropoffLoc: dropOffLocationTextField.text!, complete: false, driver: addDriverTextField.text!, tripGroup: groupNameTextField.text!)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "unwindFromAddTrip" && ((tripNameTextField.text?.isEmpty)! || (tripDateTimeLabel.text?.isEmpty)! || (pickupLocationTextField.text?.isEmpty)!)
            || (dropOffLocationTextField.text?.isEmpty)! || (groupNameTextField.text?.isEmpty)!) {
            showAlert()
            return false
        } else {
            return true
        }
    }
    
    /**
     * Presents a UIAlertViewController
     */
    func showAlert() {
        let alert = UIAlertController(title: "Oops", message: "Can't submit empty fields", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        /*let selectedRange = yourTextView.selectedRange
        yourTextView.scrollRangeToVisible(selectedRange)*/
    }

}
