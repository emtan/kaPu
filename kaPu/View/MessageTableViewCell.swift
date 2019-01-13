//
//  MessageCellTableViewCell.swift
//  kaPu
//
//  Created by Emily Tan on 12/2/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import SwiftKeychainWrapper

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var messageText: UILabel!
    
    var message: Message!
    var userPostKey: DatabaseReference!
    
    let currentUser = KeychainWrapper.standard.string(forKey: "uid")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(message: Message) {
        self.message = message
        //let senderData = Database.database().reference().child("users").child(message.sender)
    }

}
