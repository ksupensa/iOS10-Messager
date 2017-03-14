//
//  RecentVC.swift
//  Messager
//
//  Created by Spencer Forrest on 12/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class RecentC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(RecentC.logout))
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(logout), with: nil, afterDelay: 0)
        }
    }
    
    func logout(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
            Alert.message(self, title: "Logout Error", message: error.localizedDescription, buttonTitle: "Ok")
        }
        present(LoginC(), animated: true, completion: nil)
    }
}
