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
    
    private var timer = Timer()
    
    private let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            currentUsrID = uid
            setCurrentUserName(uid)
            observeUsrMsg()
        } else {
            perform(#selector(logout), with: nil, afterDelay: 0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let n = currentName {
            navigationItem.title = n
        }
    }
    
    var messages = [Message]()
    var mUsers = [String:User]()
    var messageDict = [String:Message]()
    
    private func observeUsrMsg(){
        let ref =  DB_REF.child(USR_MSG).child(currentUsrID)
        ref.observe(.childAdded) {
            (snap:FIRDataSnapshot) in
            
            let contactId = snap.key
            
            DB_REF.child(USR_MSG).child(self.currentUsrID).child(contactId).observe(.childAdded, with: { (contactSnap:FIRDataSnapshot) in
                
                let msgId = contactSnap.key
                let msgsRef = DB_REF.child(MESSAGE).child(msgId)
                
                msgsRef.observeSingleEvent(of: FIRDataEventType.value, with: {
                    (snapshot:FIRDataSnapshot) in
                    // Only show messages sent or received
                    if let dict = snapshot.value as? [String:String] {
                        let m = Message()
                        m.setValuesForKeys(dict)
                        
                        self.messageDict[contactId] = m
                        
                        // Add User if not already in dictionary
                        if self.mUsers[contactId] == nil {
                            DB_REF.child(USR).child(contactId).observeSingleEvent(of: FIRDataEventType.value, with: {
                                (snap:FIRDataSnapshot) in
                                
                                if let dict = snap.value as? [String:String] {
                                    let user = User()
                                    user.setValuesForKeys(dict)
                                    user.uid = snap.key
                                    self.mUsers[contactId] = user
                                    
                                    self.reloadTable()
                                }
                            })
                        } else {
                            self.reloadTable()
                        }
                    }
                })
            })
        }
    }
    
    private func reloadTable() {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: {
            (_: Timer) in
            
            self.messages = Array(self.messageDict.values)
            self.messages.sort(by: {
                (m1, m2) -> Bool in
                return Double(m1.timeStamp)! > Double(m2.timeStamp)!
            })
            
            self.tableView.reloadData()
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message: Message = self.messages[indexPath.row]
        let id = self.currentUsrID! == message.sender ? message.receiver : message.sender
        
        if let userWritingTo = mUsers[id]{
            showChatController(userWritingTo)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? UserCell {
            
            let message = self.messages[indexPath.row]
            let id = self.currentUsrID! == message.sender ? message.receiver : message.sender
            
            if let mUser = self.mUsers[id] {
                cell.textLabel?.text = mUser.name
                cell.detailTextLabel?.text = message.text
                if let time = Double(message.timeStamp) {
                    let stamp = Date(timeIntervalSince1970: time)
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm:ss"
                    cell.timeLabel.text = dateFormatter.string(from: stamp)
                }
                // Update Image
                cell.profileImgView.loadImgFromCache(imgUrl: mUser.imgURL)
            }
            
            return cell
        }
        
        return UserCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ICON_SIZE + 10
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
        observeUsrMsg()
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

