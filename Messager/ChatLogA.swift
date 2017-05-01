//
//  ChatLogA.swift
//  Messager
//
//  Created by Spencer Forrest on 24/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

extension ChatLogC {
    
    func uploadImgPressed() {
        print("spencer: UPLOAD TAPPED")
        let imgPickerController = UIImagePickerController()
        imgPickerController.allowsEditing = true
        imgPickerController.delegate = self
        
        present(imgPickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("we selected an image")
        
        var image: UIImage?
        
        if let imgEdited = info[UIImagePickerControllerEditedImage] as? UIImage{
            
            image = imgEdited
            
        } else if let imgOriginal = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            image = imgOriginal
            
        }
        
        if let selectedImg = image {
            uploadImgToFireStorage(img: selectedImg)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func uploadImgToFireStorage(img: UIImage) {
        print("Uploaded to Firebase - \(img.debugDescription)")
        
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgId = UUID().uuidString
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpeg"
            
            let ref = FIRStorage.storage().reference().child(IMG_MSG).child(imgId)
            
            ref.put(imgData, metadata: metaData, completion: {
                (metadata, error) in
                
                if let err = error {
                    print("Error uploading picture into Storage - \(err.localizedDescription)")
                    return
                }
                
                if let imgUrl = metadata?.downloadURL()?.absoluteString {
                    self.sendMessage(isText: false, imgUrl: imgUrl)
                }
            })
        }
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendBtnPressed()
        return true
    }
    
    func sendBtnPressed(){
        sendMessage(isText: true)
    }
    
    private func sendMessage(isText: Bool, imgUrl: String? = nil){
        print("spencer: Sending message...")
        
        // AutoId chronologically sorted
        let ref = DB_REF.child(MESSAGE).childByAutoId()
        let time = "\(NSDate().timeIntervalSince1970)"
        
        var data: String!
        var string: String!
        
        if isText {
            data = TEXT
            string = sentText.text
        } else {
            data = IMG_URL
            string = imgUrl
        }
        
        print("spencer: String of Message: \(string)\n")
        
        if let text = string, let receiverId = contact?.uid, let senderId = userId {
            let values = [data: text, RECEIVER: receiverId, SENDER: senderId, TIME: time] as [String : Any]
            ref.updateChildValues(values) {
                (error:Error?, reference:FIRDatabaseReference) in
                if let err = error {
                    print("spencer: \(err.localizedDescription)")
                    Alert.message(self, title: "Error sending message", message: err.localizedDescription, buttonTitle: "ok")
                    return
                }
                
                // Update "user-messages" for sender first...
                var usrMsgRef = DB_REF.child(USR_MSG).child(senderId).child(receiverId)
                let messageId = ref.key
                usrMsgRef.updateChildValues([messageId:1])
                
                // ...Then update "user-messages" for receiver
                usrMsgRef = DB_REF.child(USR_MSG).child(receiverId).child(senderId)
                usrMsgRef.updateChildValues([messageId:1])
            }
            
            sentText.text = ""
        }
    }
}
