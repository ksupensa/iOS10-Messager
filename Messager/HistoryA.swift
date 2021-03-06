//
//  HistoryA.swift
//  Messager
//
//  Created by Spencer Forrest on 16/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

extension HistoryC {
    func newMessage(){
        let messageC = MessageC(id: currentUsrID)
        messageC.messageController = self
        let newMsg = UINavigationController(rootViewController: messageC)
        present(newMsg, animated: true, completion: nil)
    }
    
    func showChatController(_ usr: User) {
        if usr.uid == currentUsrID! {
            print("spencer: You cannot send message to yourself")
            Alert.message(self, title: "Self messaging", message: "You cannot send message to yourself", buttonTitle: "Got it!")
        } else {
            print("spencer: Loading chat log...")
            navigationItem.title = nil
            let chatLogC = ChatLogC(collectionViewLayout: UICollectionViewFlowLayout())
            // senderID first then user or it will crash
            chatLogC.userId = currentUsrID
            chatLogC.contact = usr
            navigationController?.pushViewController(chatLogC, animated: true)
        }
    }
    
    func logout(){
        if let loggedUserId = currentUsrID {
            DB_REF.child(USR_MSG).child(loggedUserId).removeAllObservers()
            DB_REF.child(USR_MSG).child(loggedUserId).observeSingleEvent(of: .value, with: {
                (snap) in
                let contactId = snap.key
                DB_REF.child(USR_MSG).child(loggedUserId).child(contactId).removeAllObservers()
            })
            DB_REF.child(MESSAGE).removeAllObservers()
            messages.removeAll()
            messageDict.removeAll()
            mUsers.removeAll()
            tableView.reloadData()
        }
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
            Alert.message(self, title: "Logout Error", message: error.localizedDescription, buttonTitle: "Ok")
        }
        
        currentName = nil
        currentEmail = nil
        currentUsrID = nil
        
        let loginC = LoginC()
        loginC.delegate = self
        
        present(loginC, animated: true, completion: nil)
    }
}
