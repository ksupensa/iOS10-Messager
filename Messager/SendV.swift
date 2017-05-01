//
//  SendV.swift
//  Messager
//
//  Created by Spencer Forrest on 18/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class SendV: UIView {
    
    let containerV: UIView = UIView()
    let sendBtn: UIButton = UIButton(type: UIButtonType.system)
    let textField = UITextField()
    let separator = UIView()
    let uploadImgView: UIImageView = {
        let tempImgView = UIImageView(image: UIImage(named: "conversationImg"))
        tempImgView.isUserInteractionEnabled = true
        return tempImgView
    }()
    
    func setupInputViews(_ view: UIView = UIView(), size: CGRect) {
        self.frame = size
        
        view.addSubview(containerV)
        containerV.addSubview(sendBtn)
        containerV.addSubview(textField)
        containerV.addSubview(separator)
        containerV.addSubview(uploadImgView)
        
        containerV.backgroundColor = UIColor.white
        containerV.translatesAutoresizingMaskIntoConstraints = false
        // x,y,width,height
        containerV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerV.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerV.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        // x,y,width,height
        sendBtn.rightAnchor.constraint(equalTo: containerV.rightAnchor, constant: -10).isActive = true
        sendBtn.centerYAnchor.constraint(equalTo: containerV.centerYAnchor).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendBtn.heightAnchor.constraint(equalTo: containerV.heightAnchor).isActive = true
        
        textField.placeholder = "Write message here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        // x, y, width, height
        textField.leftAnchor.constraint(equalTo: uploadImgView.rightAnchor, constant: 10).isActive = true
        textField.centerYAnchor.constraint(equalTo: containerV.centerYAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: sendBtn.leftAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: containerV.heightAnchor).isActive = true
        
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        // x, y, width, height
        separator.bottomAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        separator.widthAnchor.constraint(equalTo: containerV.widthAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: containerV.leftAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        uploadImgView.translatesAutoresizingMaskIntoConstraints = false
        // x, y, width, height
        uploadImgView.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 5).isActive = true
        uploadImgView.centerYAnchor.constraint(equalTo: containerV.centerYAnchor).isActive = true
        uploadImgView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        uploadImgView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}
