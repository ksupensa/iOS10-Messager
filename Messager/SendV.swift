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
    
    func setupInputViews(_ view: UIView) {
        
        containerV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerV)
        
        containerV.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerV.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerV.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        containerV.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        sendBtn.setTitle("Send", for: .normal)
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        containerV.addSubview(sendBtn)
        // x,y,width,height
        sendBtn.rightAnchor.constraint(equalTo: containerV.rightAnchor, constant: -10).isActive = true
        sendBtn.centerYAnchor.constraint(equalTo: containerV.centerYAnchor).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sendBtn.heightAnchor.constraint(equalTo: containerV.heightAnchor).isActive = true
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write message here"
        containerV.addSubview(textField)
        // x, y, width, height
        textField.centerYAnchor.constraint(equalTo: containerV.centerYAnchor).isActive = true
        textField.leftAnchor.constraint(equalTo: containerV.leftAnchor, constant: 10).isActive = true
        textField.rightAnchor.constraint(equalTo: sendBtn.leftAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: containerV.heightAnchor).isActive = true
        
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
        containerV.addSubview(separator)
        // x, y, width, height
        separator.bottomAnchor.constraint(equalTo: textField.topAnchor).isActive = true
        separator.widthAnchor.constraint(equalTo: containerV.widthAnchor).isActive = true
        separator.leftAnchor.constraint(equalTo: containerV.leftAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
