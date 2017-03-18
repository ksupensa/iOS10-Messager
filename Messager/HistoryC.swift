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
    
    var currentName: String!
    var currentEmail: String!
    var currentUsrID: String!
    var messages = [Message]()
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            setCurrentUserName(uid)
        } else {
            perform(#selector(logout), with: nil, afterDelay: 0)
        }
        
        observeMessages()
    }
    
    private func observeMessages(){
        DB_REF.child(MESSAGE).observe(.childAdded, with: {
            (snapshot: FIRDataSnapshot) in
            // TEST
            if let dict = snapshot.value as? [String:AnyObject] {
                let m = Message()
                m.setValuesForKeys(dict)
                print("spencer: Message - \(m.text)")
                self.messages.append(m)
                self.tableView.reloadData()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? UserCell {
            cell.textLabel?.text = messages[indexPath.row].receiver
            cell.detailTextLabel?.text = messages[indexPath.row].text
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let n = currentName {
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
                user.uid = snapshot.key
                print("spencer: User downloaded")
                self.setNavigationTitleBar(user)
            } else {
                let errMsg = "Cannot reach database"
                print("spencer: \(errMsg)")
                Alert.message(self, title: "Login Error", message: errMsg, buttonTitle: "Ok")
                self.dismiss(animated: true, completion: nil)
            }
        })
    }
    
    func transferName(_ aUser: User, completed: completion) {
        print("spencer: User Transfered")
        setNavigationTitleBar(aUser)
        completed()
    }
    
    private func setNavigationTitleBar(_ usr:User){
        currentName = usr.name
        currentEmail = usr.email
        currentUsrID = usr.uid
        navigationItem.title = currentName
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newMessage))
    }
}

