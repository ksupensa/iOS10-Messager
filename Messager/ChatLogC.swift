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
    var senderID: String? {
        didSet{
             sendMessageV.sendBtn.isHidden = false
        }
    }
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
        sendMessageV.sendBtn.isHidden = true
    }
    
    func sendBtnPressed(){
        print("spencer: Sending message...")
        
        let ref = DB_REF.child(MESSAGE).childByAutoId()
        let time = "\(NSDate().timeIntervalSince1970)"
        
        if let text = sentText.text, let uid = user?.uid {
            let values = [TEXT: text, RECEIVER: uid, SENDER: senderID!, TIME: time] as [String : Any]
            ref.updateChildValues(values) {
                (error:Error?, reference:FIRDatabaseReference) in
                if let err = error {
                    print("spencer: \(err.localizedDescription)")
                    Alert.message(self, title: "Error sending message", message: err.localizedDescription, buttonTitle: "ok")
                }
            }
            
            sentText.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBtnPressed()
        return true
    }
}
