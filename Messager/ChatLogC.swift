//
//  ChatLogC.swift
//  Messager
//
//  Created by Spencer Forrest on 18/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class ChatLogC: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    // Represent the input Field part
    var sendMessageV: SendV =  {
        let tempView = SendV()
        tempView.sendBtn.addTarget(self, action: #selector(sendBtnPressed), for: UIControlEvents.touchUpInside)
        
        tempView.backgroundColor = UIColor.yellow
        
        return tempView
    }()

    weak var sentText: UITextField!
    let cellId = "cellId"
    var userId: String?
    
    var contact: User? {
        didSet{
            navigationItem.title = contact?.name
            observeMsg()
        }
    }
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendMessageV.textField.delegate = self
        sentText = sendMessageV.textField
        let inputViewSize = CGRect(x: 0, y: 0, width: view.frame.width, height: SENDV_HEIGHT)
        sendMessageV.setupInputViews(inputAccessoryView!,size: inputViewSize)
        
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.alwaysBounceVertical = true
        collectionView?.keyboardDismissMode = .interactive
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(ChatLogCell.self, forCellWithReuseIdentifier: cellId)
        
        // Put 'collectionView' above 'sendMessageV'
        resizeSlideView(top: 10, bottom: 10)
        
        // Dismiss keyboard if 'view' tapped
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Select image to upload if 'uploadImgView' tapped
        let tapImg = UITapGestureRecognizer(target: self, action: #selector(uploadImgPressed))
        sendMessageV.uploadImgView.addGestureRecognizer(tapImg)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // Used to automatically be "stuck" on the keyboard
    override var inputAccessoryView: UIView? {
        get {
            return sendMessageV
        }
    }
    
    // Needed for inputAccessoryView to show
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    func dismissKeyboard() {
        sendMessageV.textField.resignFirstResponder()
        sendMessageV.textField.endEditing(true)
    }
    
    private func resizeSlideView(top: CGFloat = 70, bottom: CGFloat = 0) {
        collectionView?.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
    }
    
    private func observeMsg() {
        
        guard let contactId = contact?.uid else {
            print("spencer: Contact.uid does not exist")
            return
        }
        
        let ref = DB_REF.child(USR_MSG).child(userId!).child(contactId)
        ref.observe(.childAdded) {
            (snap:FIRDataSnapshot) in
            
            let msgId = snap.key
            
            DB_REF.child(MESSAGE).child(msgId).observeSingleEvent(of: .value, with: {
                (snap2:FIRDataSnapshot) in
                
                if let dict = snap2.value as? [String:String] {
                    let msg = Message()
                    msg.setValuesForKeys(dict)
                    self.messages.append(msg)
                    
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        self.getLastMessageToAppear()
                    }
                }
            })
        }
    }
    
    private func getLastMessageToAppear() {
        // Get the bottom part of UICollectionView
        let lastItem = self.messages.count - 1
        let lastItemIndex = IndexPath(item: lastItem, section: 0)
        self.collectionView?.scrollToItem(at: lastItemIndex, at: UICollectionViewScrollPosition.top, animated: false)
    }
    
    private func setupCollectionView() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatLogCell
        
        let msg: Message = messages[indexPath.row]
        
        // Need to differenciate logged user from contact
        let isUser = msg.sender == userId
        
        if let text = msg.text {
            cell.setText(text, isUser: isUser)
            cell.messageImgView.isHidden = true
            cell.txtV.isHidden = false
            
            cell.backgroundColor = UIColor.clear
        } else if let imgUrl = msg.imgURL {
            cell.setText("", isUser: true)
            cell.txtV.isHidden = true
            cell.messageImgView.isHidden = false
            cell.setImg(imgUrl)
            
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = view.frame.width
        
        if let txt = messages[indexPath.row].text {
        
            let size = CellSize.getCellSizeToFitText(txt, maxWidth: cellWidth * 0.6).size!
            
            // Give size of the Cell
            return CGSize(width: cellWidth, height: size.height)
        } else {
            
            print("spencer: 100 of Height")
            return CGSize(width: cellWidth, height: 100)
        }
    }
}
