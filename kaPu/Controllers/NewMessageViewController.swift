//
//  NewMessageViewController.swift
//  kaPu
//
//  Created by Emily Tan on 12/1/18.
//  Copyright © 2018 Emily Tan. All rights reserved.
//

import UIKit
import Foundation
import Photos
import Firebase
import FirebaseFirestore
import FirebaseAuth
import MessageKit
import MessageInputBar

final class NewMessageViewController: MessagesViewController {
    
    private var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    
    private let user: User
    private let channel: Channel
    
    init(user: User, channel: Channel, aDecoder: NSCoder) {
        self.user = user
        self.channel = channel
        super.init(nibName: nil, bundle: nil)
        
        // title = channel.channelName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.largeTitleDisplayMode = .never
        
        // set up messaging
        messageInputBar.delegate = self
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .orange
        messageInputBar.sendButton.setTitleColor(.orange, for: .normal)
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

// MARK: - MessagesDisplayDelegate

extension NewMessageViewController: MessagesDisplayDelegate {
    
}

// MARK: - MessagesLayoutDelegate

extension NewMessageViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
}

// MARK: - MessagesDataSource

extension NewMessageViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
        return Sender(id: (Auth.auth().currentUser?.uid)!, displayName: (Auth.auth().currentUser?.displayName)!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section] as! MessageType 
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return 1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
}

// MARK: - MessageInputBarDelegate

extension NewMessageViewController: MessageInputBarDelegate {
    
}

// MARK: - UIImagePickerControllerDelegate

extension NewMessageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

