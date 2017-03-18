//
//  HistoryC.swift
//  Messager
//
//  Created by Spencer Forrest on 12/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class HistoryC: UITableViewController, RecentD {
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newMessage))
        
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            setCurrentUserName(uid)
        } else {
            perform(#selector(logout), with: nil, afterDelay: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let n = name {
            navigationItem.title = n
        }
    }
    
    func setCurrentUserName(_ uid: String) {
        DB_REF.child(USR).child(uid).observeSingleEvent(of: FIRDataEventType.value, with: {
            (snapshot: FIRDataSnapshot) in
            if let dict = snapshot.value as? [String:AnyObject] {
                // Get the Current User
                let user = User()
                user.setValuesForKeys(dict)
                
                print("spencer: User downloaded")
                self.setNavigationTitleBar(user)
            } else {
                let errMsg = "Cannot reach database"
                print("spencer: \(errMsg)")
                Alert.message(self, title: "Login", message: errMsg, buttonTitle: "Ok")
            }
        })
    }
    
    func transferName(_ aUser: User, completed: completion) {
        print("spencer: User Transfered")
        setNavigationTitleBar(aUser)
        completed()
    }
    
    private func setNavigationTitleBar(_ usr:User){
        name = usr.name
        navigationItem.title = name
        let tap = UITapGestureRecognizer(target: self, action: #selector(showChatController))
        self.view.addGestureRecognizer(tap)
    }
    
    func showChatController() {
        print("spencer: Loading chat log...")
        navigationItem.title = nil
        let chatLogC = ChatLogC(collectionViewLayout: UICollectionViewFlowLayout())
        navigationController?.pushViewController(chatLogC, animated: true)
    }
}
