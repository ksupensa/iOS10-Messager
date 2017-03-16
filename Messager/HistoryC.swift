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
    
    func setCurrentUserName(_ uid: String) {
        DB_REF.child(USR).child(uid).observeSingleEvent(of: FIRDataEventType.value, with: {
            (snapshot: FIRDataSnapshot) in
            if let dict = snapshot.value as? [String:AnyObject] {
                self.navigationItem.title = dict[NAME] as? String
            } else {
                let errMsg = "Cannot reach database"
                print("spencer: \(errMsg)")
                Alert.message(self, title: "Login", message: errMsg, buttonTitle: "Ok")
            }
        })
    }
    
    func transferName(_ str: String?, completed: completion) {
        print("spencer: Name Transfered")
        navigationItem.title = str
        completed()
    }
}
