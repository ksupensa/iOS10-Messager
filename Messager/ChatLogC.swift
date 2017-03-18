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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Chat Log Controller"
        collectionView?.backgroundColor = UIColor.white
        
        sendMessageV.textField.delegate = self
        sentText = sendMessageV.textField
        
        sendMessageV.setupInputViews(self.view)
        
        sendMessageV.sendBtn.addTarget(self, action: #selector(sendBtnPressed), for: UIControlEvents.touchUpInside)
    }
    
    func sendBtnPressed(){
        print("spencer: Sending message...")
        
        let ref = DB_REF.child(MESSAGE).childByAutoId()
        
        let values = ["text": sentText.text!]
        ref.updateChildValues(values) {
            (error:Error?, reference:FIRDatabaseReference) in
            if let err = error {
                print("sepncer: \(err.localizedDescription)")
                Alert.message(self, title: "Error sending message", message: err.localizedDescription, buttonTitle: "ok")
            }
        }
        
        sentText.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBtnPressed()
        return true
    }
}
