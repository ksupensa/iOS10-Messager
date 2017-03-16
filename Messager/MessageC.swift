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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        
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
            if let dict = snasphot.value as? [String: AnyObject] {
                let usr = User()
                usr.setValuesForKeys(dict)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let user = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
}
