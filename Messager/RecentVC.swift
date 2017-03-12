//
//  RecentVC.swift
//  Messager
//
//  Created by Spencer Forrest on 12/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class RecentVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(RecentVC.logout))
    }
    
    func logout(){
        present(LoginVC(), animated: true, completion: nil)
    }
}

