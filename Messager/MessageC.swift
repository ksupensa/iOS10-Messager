//
//  MessageC.swift
//  Messager
//
//  Created by Spencer Forrest on 15/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class MessageC: UITableViewController {
    
    private let cellId = "msgCell"
    private var users = [User]()
    var currentUsrID: String!
    
    init(id: String) {
        super.init(style: UITableViewStyle.plain)
        currentUsrID = id
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.title = "List of users"
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        DB_REF.child(USR).removeAllObservers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
    }
    
    func fetchUser(){
        DB_REF.child(USR).observe(.childAdded) {
            (snasphot:FIRDataSnapshot) in
            
            // We don't want to include the current user
            if self.currentUsrID == snasphot.key {
                return
            }
            
            if let dict = snasphot.value as? [String: AnyObject] {
                let usr = User()
                usr.setValuesForKeys(dict)
                usr.uid = snasphot.key
                self.users.append(usr)
            }
            
            // No need for DispatchQueue.main.async
            // Firabase closure execute on main Queue
            self.tableView.reloadData()
        }
    }
    
    func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ICON_SIZE + 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        if let imgUrl = user.imgURL {
            cell.profileImgView.loadImgFromCache(imgUrl: imgUrl)
        }
        
        return cell
    }
    
    var messageController: HistoryC!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.messageController?.showChatController(user)
        }
    }
}
