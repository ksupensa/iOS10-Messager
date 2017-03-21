//
//  ChatLogC.swift
//  Messager
//
//  Created by Spencer Forrest on 18/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class ChatLogC: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    
    // Represent the input Field part
    let sendMessageV = SendV()
    var sentText: UITextField!

    let cellId = "cellId"
    
    var userId: String?
    
    var contact: User? {
        didSet{
            navigationItem.title = contact?.name
            observeMsg()
        }
    }
    
    var messages = [Message]()
    
    private func observeMsg() {
        let ref  = DB_REF.child(USR_MSG).child(userId!)
        ref.observe(.childAdded) {
            (snap:FIRDataSnapshot) in
            
            let msgId = snap.key
            
            DB_REF.child(MESSAGE).child(msgId).observeSingleEvent(of: .value, with: {
                (snap2:FIRDataSnapshot) in
                
                if let dict = snap2.value as? [String:String] {
                    let sendId = dict[SENDER]!
                    let receiveId = dict[RECEIVER]!
                    
                    guard sendId == self.contact?.uid || receiveId == self.contact?.uid else {
                        return
                    }
                    
                    let msg = Message()
                    msg.setValuesForKeys(dict)
                    self.messages.append(msg)
                    print(msg.text)
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellId)
        
        sendMessageV.textField.delegate = self
        sentText = sendMessageV.textField
        
        sendMessageV.setupInputViews(self.view)
        
        sendMessageV.sendBtn.addTarget(self, action: #selector(sendBtnPressed), for: UIControlEvents.touchUpInside)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCell
        
        let msg = messages[indexPath.row]
        
        // Need to differenciate logged user from contact
        let isUser = msg.sender == userId
        cell.setText(msg.text, isUser: isUser)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let msg = NSString(string: messages[indexPath.row].text)
        let size =  msg.size(attributes: [NSFontAttributeName: FONT!])
        let height: CGFloat = size.height + MSG_PADDING
        
        // Estimated height
        return CGSize(width: view.frame.width, height: height)
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
                var usrMsgRef = DB_REF.child(USR_MSG).child(senderId)
                let messageId = ref.key
                usrMsgRef.updateChildValues([messageId:1])
                
                // ...Then update "user-messages" for receiver
                usrMsgRef = DB_REF.child(USR_MSG).child(receiverId)
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
