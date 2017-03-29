//
//  ChatLogA.swift
//  Messager
//
//  Created by Spencer Forrest on 24/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

extension ChatLogC {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBtnPressed()
        return true
    }
    
    func sendBtnPressed(){
        print("spencer: Sending message...")
        
        // AutoId chronologically sorted
        let ref = DB_REF.child(MESSAGE).childByAutoId()
        let time = "\(NSDate().timeIntervalSince1970)"
        
        if let text = sentText.text, let receiverId = contact?.uid, let senderId = userId {
            let values = [TEXT: text, RECEIVER: receiverId, SENDER: senderId, TIME: time] as [String : Any]
            ref.updateChildValues(values) {
                (error:Error?, reference:FIRDatabaseReference) in
                if let err = error {
                    print("spencer: \(err.localizedDescription)")
                    Alert.message(self, title: "Error sending message", message: err.localizedDescription, buttonTitle: "ok")
                    return
                }
                
                // Update "user-messages" for sender first...
                var usrMsgRef = DB_REF.child(USR_MSG).child(senderId).child(receiverId)
                let messageId = ref.key
                usrMsgRef.updateChildValues([messageId:1])
                
                // ...Then update "user-messages" for receiver
                usrMsgRef = DB_REF.child(USR_MSG).child(receiverId).child(senderId)
                usrMsgRef.updateChildValues([messageId:1])
            }
            
            sentText.text = ""
        }
    }
}
