//
//  NewGroupViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/2/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase

class NewGroupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveNewGroupButton: UIBarButtonItem!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var addMembersTextField: UITextField!
    @IBOutlet weak var addKidsTextField: UITextField!
    var group: Group?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        groupNameTextField.useUnderline()
        addMembersTextField.useUnderline()
        addKidsTextField.useUnderline()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        self.group = Group(groupName: groupNameTextField.text!, groupMembers: addMembersTextField.text!.components(separatedBy: ", "), groupKids: addKidsTextField.text!.components(separatedBy: ", "))
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "unwindFromAddGroup" && ((groupNameTextField.text?.isEmpty)! || (addMembersTextField.text?.isEmpty)! || (addKidsTextField.text?.isEmpty)!)) {
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

extension UITextField {
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.5)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
