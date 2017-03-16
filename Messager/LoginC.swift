//
//  LoginC.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class LoginC: UIViewController {
    weak var delegate: RecentD?
    
    private var lv = LoginV()
    private var login = true
    private weak var btn: UIButton!
    private weak var sc: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lv)
        
        btn = lv.registerLoginBtn
        sc = lv.segmentedControl
        
        lv.setupView(view: view)
        setupActions()
    }
    
    private func setupActions(){
        lv.segmentedControl.addTarget(self, action: #selector(segmentControlChanged), for: UIControlEvents.valueChanged)
        lv.registerLoginBtn.addTarget(self, action: #selector(registerBtnTapped), for: UIControlEvents.touchUpInside)
    }
    
    func segmentControlChanged() {
        let sc = lv.segmentedControl
        let index = sc.selectedSegmentIndex
        if let title = sc.titleForSegment(at:index ) {
            lv.registerLoginBtn.setTitle(title, for: UIControlState.normal)
            login = index == 0
            
            // Change layout of input fields
            inputFieldsLayout(login)
        }
    }
    
    private func inputFieldsLayout(_ login: Bool){
        lv.inputsViewHeightConstraint?.constant = login ? 100 : 150
        let iVHA = lv.inputsView.heightAnchor
        let top = login ? lv.inputsView.topAnchor : lv.nameTxtField.bottomAnchor
        let multiplier:CGFloat = login ? 1/2 : 1/3
        
        lv.nameTxtField.isHidden = login
        lv.emailSeparatorView.isHidden = login
        
        lv.emailTopConstraint?.isActive = false
        lv.emailTopConstraint = lv.emailTxtField.topAnchor.constraint(equalTo: top)
        lv.emailTopConstraint?.isActive = true
        
        lv.emailHeightConstraint?.isActive = false
        lv.emailHeightConstraint = lv.emailTxtField.heightAnchor.constraint(equalTo: iVHA, multiplier: multiplier)
        lv.emailHeightConstraint?.isActive = true
        
        lv.passwordHeightConstraint?.isActive = false
        lv.passwordHeightConstraint = lv.passwordTxtField.heightAnchor.constraint(equalTo: iVHA, multiplier: multiplier)
        lv.passwordHeightConstraint?.isActive = true
    }
    
    func registerBtnTapped(){
        guard let email = lv.emailTxtField.text, let password = lv.passwordTxtField.text, let name = lv.nameTxtField.text else {
            return
        }
        
        if login{
            logUserIn(email, password: password)
        } else {
            createUser(email, password: password, name: name)
        }
    }
    
    private func logUserIn(_ email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user: FIRUser?, error:Error?) in
            
            if let err = error {
                print("spencer: Login Error - \((err.localizedDescription))")
                Alert.message(self, title: "Login error", message: (err.localizedDescription), buttonTitle: "Ok")
                return
            }
            
            let uid = (user)!.uid
            var name: String?
            
            DB_REF.child(USR).child(uid).observeSingleEvent(of: FIRDataEventType.value, with: {
                (snapshot: FIRDataSnapshot) in
                
                if let dict = snapshot.value as? [String:AnyObject] {
                    name = dict[NAME] as? String
                    // log into the App
                    self.login(name)
                } else {
                    let errMsg = "Cannot reach database"
                    print("spencer: \(errMsg)")
                    Alert.message(self, title: "Login", message: errMsg, buttonTitle: "Ok")
                }
            })
        })
    }
    
    private func createUser(_ email: String, password: String, name: String) {
        AUTH_REF?.createUser(withEmail: email, password: password, completion: {
            (user: FIRUser?, error: Error?) in
            
            if let err = error {
                print("spencer: Error creating user - \(err.localizedDescription)")
                Alert.message(self, title: "Error creating user", message: err.localizedDescription, buttonTitle: "Understood")
                return
            }
            
            // User got authenticated
            if let usr = user {
                let values = [NAME: name, EMAIL: email]
                
                let userRef = DB_REF.child(USR).child(usr.uid)
                userRef.updateChildValues(values, withCompletionBlock: {
                    (error, ref) in
                    if let err = error {
                        print("spencer: Error saving user - \(err.localizedDescription)")
                        Alert.message(self, title: "Error saving user", message: err.localizedDescription, buttonTitle: "Understood")
                        return
                    }
                    
                    // log into the App
                    self.login(name)
                })
            }
        })
    }
    
    // Transfert Name back to previous delegate
    func login(_ name: String?) {
        delegate?.transferName(name, completed: {
            // Dismiss this view
            self.lv.clearInputFields()
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
