//
//  ChatLogC.swift
//  Messager
//
//  Created by Spencer Forrest on 18/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class ChatLogC: UICollectionViewController, UITextFieldDelegate {
    
    // Represent the editable part
    let sendMessageV = SendV()
    var sentText: UITextField!
    
    var senderID: String?
    
    var user: User? {
        didSet{
            navigationItem.title = user?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        
        sendMessageV.textField.delegate = self
        sentText = sendMessageV.textField
        
        sendMessageV.setupInputViews(self.view)
        
        sendMessageV.sendBtn.addTarget(self, action: #selector(sendBtnPressed), for: UIControlEvents.touchUpInside)
    }
    
    func sendBtnPressed(){
        print("spencer: Sending message...")
        
        // AutoId chronologically sorted
        let ref = DB_REF.child(MESSAGE).childByAutoId()
        let time = "\(NSDate().timeIntervalSince1970)"
        
        if let text = sentText.text, let receiverId = user?.uid, let senderId = senderID {
            let values = [TEXT: text, RECEIVER: receiverId, SENDER: senderId, TIME: time] as [String : Any]
            ref.updateChildValues(values) {
                (error:Error?, reference:FIRDatabaseReference) in
                if let err = error {
                    print("spencer: \(err.localizedDescription)")
                    Alert.message(self, title: "Error sending message", message: err.localizedDescription, buttonTitle: "ok")
                    return
                }
                
                // Update "user-messages" for sender first...
                var usrMsgRef = DB_REF.child(MESSAGE).child(USR_MSG).child(senderId)
                let messageId = ref.key
                usrMsgRef.updateChildValues([messageId:1])
                
                // ...Then update "user-messages" for receiver
                usrMsgRef = DB_REF.child(MESSAGE).child(USR_MSG).child(receiverId)
                usrMsgRef.updateChildValues([messageId:1])
            }
            
            sentText.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBtnPressed()
        return true
    }
}
