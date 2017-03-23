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
        label.font = UIFont(name: FONT_NAME, size: 12)
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
        timeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

