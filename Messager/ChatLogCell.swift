//
//  ChatLogCell.swift
//  Messager
//
//  Created by Spencer Forrest on 21/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class ChatLogCell: UICollectionViewCell {
    
    let txtV: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textAlignment = NSTextAlignment.center
        tv.isEditable = false
        tv.isSelectable = false
        tv.isUserInteractionEnabled = true
        tv.isScrollEnabled = false
        return tv
    }()
    
    let  bubbleV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 18
        return view
    }()
    
    let messageImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.backgroundColor = UIColor.purple
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleV)
        addSubview(txtV)
        
        bubbleV.addSubview(messageImgView)
        
        // Anchors: x, y, width, height
        messageImgView.leftAnchor.constraint(equalTo: bubbleV.leftAnchor).isActive = true
        messageImgView.topAnchor.constraint(equalTo: bubbleV.topAnchor).isActive = true
        messageImgView.widthAnchor.constraint(equalTo: bubbleV.widthAnchor).isActive = true
        messageImgView.heightAnchor.constraint(equalTo: bubbleV.heightAnchor).isActive = true
        
        // Anchors: x, y, width, height
        txtV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        // Anchors: x, y, width, height
        bubbleV.topAnchor.constraint(equalTo: txtV.topAnchor).isActive = true
        bubbleV.leftAnchor.constraint(equalTo: txtV.leftAnchor).isActive = true
        bubbleV.rightAnchor.constraint(equalTo: txtV.rightAnchor).isActive = true
        bubbleV.bottomAnchor.constraint(equalTo: txtV.bottomAnchor).isActive = true
    }
    
    func setImg(_ url: String? = nil){
        messageImgView.loadImgFromCache(imgUrl: url)
    }
    
    var textW: NSLayoutConstraint!
    var textH: NSLayoutConstraint!
    var textRL: NSLayoutConstraint!
    var bubbleW: NSLayoutConstraint!
    var bubbleH: NSLayoutConstraint!
    var bubbleRL: NSLayoutConstraint!
    
    func setText(_ txt: String, isUser: Bool) {
        let cellsize = CellSize.getCellSizeToFitText(txt, maxWidth: self.frame.width * 0.6)
        txtV.attributedText = cellsize.attributedString
        
        // Give size of the Cell
        let size = cellsize.size!
        let w = size.width
        let h = size.height
        
        // Update textView size et position
        if let tw = textW, let th = textH, let trl = textRL {
            tw.isActive = false
            th.isActive = false
            trl.isActive = false
        }
        
        textW = txtV.widthAnchor.constraint(equalToConstant: w)
        textW.isActive = true
        textH = txtV.heightAnchor.constraint(equalToConstant: h)
        textH.isActive = true
        
        let padding:CGFloat = 10
        
        // Side of Text and Bubble depends on Contact and User
        if isUser {
            textRL = txtV.rightAnchor.constraint(equalTo: self.rightAnchor , constant: -padding)
            textRL.isActive = true
            bubbleV.backgroundColor = UIColor(r: 0, g: 137, b: 249)
            txtV.textColor = UIColor.white
        } else {
            textRL = txtV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding)
            textRL.isActive = true
            bubbleV.backgroundColor = UIColor(r: 230, g: 230, b: 230)
            txtV.textColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
