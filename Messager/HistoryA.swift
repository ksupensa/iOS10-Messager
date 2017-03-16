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
        let newMsg = UINavigationController(rootViewController: MessageC())
        present(newMsg, animated: true, completion: nil)
    }
    
    func logout(){
        do {
            try FIRAuth.auth()?.signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
            Alert.message(self, title: "Logout Error", message: error.localizedDescription, buttonTitle: "Ok")
        }
        
        let loginC = LoginC()
        loginC.delegate = self
        
        present(loginC, animated: true, completion: nil)
    }
}
