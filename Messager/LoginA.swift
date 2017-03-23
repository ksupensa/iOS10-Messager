//
//  LoginA.swift
//  Messager
//
//  Created by Spencer Forrest on 16/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

extension LoginC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func segmentControlChanged() {
        let sc = lv.segmentedControl
        let index = sc.selectedSegmentIndex
        if let title = sc.titleForSegment(at:index ) {
            lv.registerLoginBtn.setTitle(title, for: UIControlState.normal)
            signIn = index == 0
            
            // Change layout of input fields
            inputFieldsLayout(signIn)
        }
    }
    
    func registerBtnTapped(){
        guard let email = lv.emailTxtField.text, let password = lv.passwordTxtField.text, let name = lv.nameTxtField.text else {
            return
        }
        
        if signIn{
            logUserIn(email, password: password)
        } else {
            createUser(email, password: password, name: name)
        }
    }
    
    func profileImgTapped(){
        //Alert.message(self, title: "Spencer", message: "Profile image tapped", buttonTitle: "Yes, Sir!")
        let imgPicker = UIImagePickerController()
        imgPicker.allowsEditing = true
        imgPicker.delegate = self
        
        present(imgPicker, animated: true, completion: nil)
    }
    
    // 2 functions needed for (UIImagePickerControllerDelegate and UINavigationControllerDelegate)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        hasDefaultImg = false
        
        if let imgEdited = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            self.img.image = imgEdited
            
        } else if let imgOriginal = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            self.img.image = imgOriginal
            
        } else {
            print("spencer: Error during profile image selection")
            hasDefaultImg = true
            img.image = UIImage(named: CAMERA_IMG)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        hasDefaultImg = true
        img.image = UIImage(named: CAMERA_IMG)
        picker.dismiss(animated: true, completion: nil)
    }
    //-------------------------------------------------------------------------------------------------
    
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
    
    private func logUserIn(_ email: String, password: String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: {
            (user: FIRUser?, error:Error?) in
            
            if let err = error {
                print("spencer: Login Error - \((err.localizedDescription))")
                Alert.message(self, title: "Login error", message: (err.localizedDescription), buttonTitle: "Ok")
                return
            }
            
            let uid = (user)!.uid
            
            DB_REF.child(USR).child(uid).observeSingleEvent(of: FIRDataEventType.value, with: {
                (snapshot: FIRDataSnapshot) in
                
                if let dict = snapshot.value as? [String:AnyObject] {
                    
                    // log into the App
                    self.login(dict, uid: uid)
                } else {
                    let errMsg = "Cannot reach database"
                    print("spencer: \(errMsg)")
                    Alert.message(self, title: "Login", message: errMsg, buttonTitle: "Ok")
                }
            })
        })
    }
    
    private func createUser(_ email: String, password: String, name: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {
            (user: FIRUser?, error: Error?) in
            
            if let err = error {
                print("spencer: Error creating user - \(err.localizedDescription)")
                Alert.message(self, title: "Error creating user", message: err.localizedDescription, buttonTitle: "Understood")
                return
            }
            
            // User got authenticated
            if let usr = user {
                
                // Prepare values to set new User
                var values: [String:AnyObject] = [NAME: name as AnyObject, EMAIL: email as AnyObject]
                
                print("spencer: Default Image - \(self.hasDefaultImg)")
                
                if !self.hasDefaultImg {
                    if let img = self.img.image, let data = UIImageJPEGRepresentation(img, 0.2) {
                        let metaData = FIRStorageMetadata()
                        metaData.contentType = "image/jpeg"
                        
                        let imgId = UUID().uuidString
                        
                        FIRStorage.storage().reference().child("profile-img").child(imgId).put(data, metadata: metaData) {
                            (meta:FIRStorageMetadata?, strErr:Error?) in
                            if let err = strErr {
                                print(err.localizedDescription)
                                Alert.message(self, title: "Error saving profile image", message: err.localizedDescription, buttonTitle: "Understood")
                                return
                            }
                            
                            // Get URL if existing
                            if let url = meta?.downloadURL()?.absoluteString {
                                // Prepare values to set new User
                                values = [NAME: name as AnyObject, EMAIL: email as AnyObject, IMG_URL: url as AnyObject]
                            }
                            
                            self.saveNewUserInDB(usr, values: values)
                        }
                    }
                } else {
                    self.saveNewUserInDB(usr, values: values)
                }
            }
        })
    }
    
    private func saveNewUserInDB(_ usr: FIRUser, values: [String:AnyObject]) {
        // Set new User in Database
        let userRef = DB_REF.child(USR).child(usr.uid)
        userRef.updateChildValues(values, withCompletionBlock: {
            (error, ref) in
            
            if let err = error {
                print("spencer: Error saving user - \(err.localizedDescription)")
                Alert.message(self, title: "Error saving user", message: err.localizedDescription, buttonTitle: "Understood")
                return
            }
            
            // log into the App
            self.login(values, uid: usr.uid)
        })
    }
}
