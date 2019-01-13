//
//  MessagesListViewController.swift
//  kaPu
//
//  Created by Emily Tan on 11/30/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import MessageKit
import MessageInputBar

class MessagesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

    @IBOutlet weak var composeMessageButton: UIBarButtonItem!
    @IBOutlet weak var searchMessageBar: UISearchBar!
    @IBOutlet weak var messagesTableView: UITableView!
    
    private let channelCellIdentifier = "channelCell"
    private var currentChannelAlertController: UIAlertController?
    
    // private let db = Firestore.firestore()
    private let ref = Database.database().reference()
    
    /*private var channelReference: CollectionReference {
        return db.collection("channels")
    }*/
    
    //private let currUser: User
    private var channels = [Channel]()
    // private var channelListener: ListenerRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        
        /*channelListener = channelReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }*/
    }
    
    @IBAction func composeMessageAction(_ sender: Any) {
        self.performSegue(withIdentifier: "createMessage", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    private func handleDocumentChange(_ change: DocumentChange) {
        // TO DO: handle document changes
    }
}
