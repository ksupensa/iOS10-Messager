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
        tv.font = FONT
        tv.textAlignment = NSTextAlignment.center
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isSelectable = false
        tv.isUserInteractionEnabled = true
        return tv
    }()
    
    let  bubbleV: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bubbleV)
        addSubview(txtV)
        
        // Anchors: x, y, width, height
        txtV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        // Anchors: x, y, width, height
        bubbleV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    var textW: NSLayoutConstraint!
    var textH: NSLayoutConstraint!
    var textRL: NSLayoutConstraint!
    var bubbleW: NSLayoutConstraint!
    var bubbleH: NSLayoutConstraint!
    var bubbleRL: NSLayoutConstraint!
    
    func setText(_ txt: String?, isUser: Bool) {
        txtV.text = txt
        
        // Compute the size of txt
        let text = NSString(string: txt!)
        let size = text.size(attributes: [NSFontAttributeName: FONT!])
        let h = size.height + MSG_PADDING
        let w = size.width + MSG_PADDING
        
        // Update textView size et position
        if let tw = textW, let th = textH, let tr = textRL {
            tw.isActive = false
            th.isActive = false
            tr.isActive = false
        }
        
        textW = txtV.widthAnchor.constraint(equalToConstant: w)
        textW.isActive = true
        textH = txtV.heightAnchor.constraint(equalToConstant: h)
        textH.isActive = true
        
        // Update bubbleView size et position
        if let bw = bubbleW, let bh = bubbleH, let br = bubbleRL {
            bw.isActive = false
            bh.isActive = false
            br.isActive = false
        }
        
        bubbleW = bubbleV.widthAnchor.constraint(equalToConstant: w)
        bubbleW.isActive = true
        bubbleH = bubbleV.heightAnchor.constraint(equalToConstant: h)
        bubbleH.isActive = true
        
        let padding:CGFloat = 10
        
        // Side of Text and Bubble depends on Contact and User
        if isUser {
            textRL = txtV.rightAnchor.constraint(equalTo: self.rightAnchor , constant: -padding)
            textRL.isActive = true
            bubbleRL = bubbleV.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -padding)
            bubbleRL.isActive = true
            bubbleV.backgroundColor = UIColor(r: 0, g: 137, b: 249)
            txtV.textColor = UIColor.white
        } else {
            textRL = txtV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding)
            textRL.isActive = true
            bubbleRL = bubbleV.leftAnchor.constraint(equalTo: self.leftAnchor, constant: padding)
            bubbleRL.isActive = true
            bubbleV.backgroundColor = UIColor(r: 230, g: 230, b: 230)
            txtV.textColor = UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
