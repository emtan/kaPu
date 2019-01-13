//
//  SignupViewController.swift
//  kaPu
//
//  Created by Emily Tan on 11/29/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseDatabase
//import CoreLocation
//import GeoFire

class SignupViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var backtoLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func createAccount(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, err) in
            if (err == nil) {
                let userData = [
                    "name": self.name.text!,
                    "email": self.email.text!,
                    "mobile": self.mobile.text!
                ]
                let ref = Database.database().reference()
                ref.child("users").child(Auth.auth().currentUser!.uid).setValue(userData)
                self.performSegue(withIdentifier: "signupSegue", sender: self)
            } else {
                let alertController = UIAlertController(title: "Error", message: err?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.name.text
        changeRequest?.commitChanges(completion: { (error) in
            print("set user's name to \(String(describing: self.name.text))")
        })
    }
    
    @IBAction func backtoLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "backtoLoginSegue", sender: self)
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
