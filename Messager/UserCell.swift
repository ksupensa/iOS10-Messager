//
//  UserCell.swift
//  Messager
//
//  Created by Spencer Forrest on 16/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell {
    
    var currentUsrID = ""
    
    let profileImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: CAMERA_IMG)
        imageView.layer.cornerRadius = ICON_SIZE/2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        return imageView
    }()
    
    let timeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "HH:MM:SS"
        label.font = UIFont(name: "Avenir", size: 12)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImgView)
        addSubview(timeLabel)
        
        // Constraints Anchors
        // x + y
        profileImgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // Width + Height
        profileImgView.heightAnchor.constraint(equalToConstant: ICON_SIZE).isActive = true
        profileImgView.widthAnchor.constraint(equalToConstant: ICON_SIZE).isActive = true
        
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 19).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: (textLabel?.leftAnchor)!).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
        
        timeLabel.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let spaceLabels:CGFloat = 2
        let xPosition = ICON_SIZE + 15
        
        var originalY = (textLabel?.frame.origin.y)! - spaceLabels
        var originalWidth = (textLabel?.frame.width)!
        var originalHeight = (textLabel?.frame.height)!
        
        textLabel?.frame = CGRect(x: xPosition, y: originalY, width: originalWidth, height: originalHeight)
        
        originalY = (detailTextLabel?.frame.origin.y)! + spaceLabels
        originalWidth = (detailTextLabel?.frame.width)!
        originalHeight = (detailTextLabel?.frame.height)!
        
        detailTextLabel?.frame = CGRect(x: xPosition, y: originalY, width: originalWidth, height: originalHeight)
    }
    
    func setupContent(message: Message){
        let receiverId = message.receiver
        let senderId = message.sender
        
        // Download data of message sent and received
        let id = senderId == currentUsrID ? receiverId : senderId
        
        DB_REF.child(USR).child(id).observeSingleEvent(of: FIRDataEventType.value, with: { (snap:FIRDataSnapshot) in
            if let dict = snap.value as? [String:String] {
                self.textLabel?.text = dict[NAME]
                
                if let imgUrl = dict[IMG_URL] {
                    self.profileImgView.loadImgFromCache(imgUrl: imgUrl)
                }
            }
        })
        
        self.detailTextLabel?.text = message.text
        if let time = Double(message.timeStamp) {
            let stamp = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            self.timeLabel.text = dateFormatter.string(from: stamp)
        }
        
        timeLabel.isHidden = false
    }
    
    override func prepareForReuse() {
        profileImgView.image = UIImage(named: CAMERA_IMG)
        detailTextLabel?.text = ""
        textLabel?.text = ""
        timeLabel.text = ""
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

