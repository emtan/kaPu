//
//  AddChildViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/7/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase

class AddChildViewController: UIViewController {
    @IBOutlet weak var childName: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var kid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.kid = nameTextField.text
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "unwindFromAddChild" && ((ageTextField.text?.isEmpty)! || (nameTextField.text?.isEmpty)! || (schoolTextField.text?.isEmpty)!)) {
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

}
