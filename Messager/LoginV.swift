//
//  LoginV.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class LoginV: UIView {
    
    var nameTxtField: UITextField!
    var emailTxtField: UITextField!
    var passwordTxtField: UITextField!
    
    var emailSeparatorView: UIView!
    var passwordSeparatorView: UIView!
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login","Register"])
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let registerLoginBtn: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 61, g: 92, b: 149)
        button.setTitle("Login", for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        // Font + Color
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont(name: "Avenir", size: 16)
        return button
    }()
    
    let profileImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: CAMERA_IMG)
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        passwordTxtField = factoryTxtField(placeholder: "Password")
        emailTxtField = factoryTxtField(placeholder: "Email")
        nameTxtField = factoryTxtField(placeholder: "Name")
        
        emailSeparatorView = factorySeparatorView()
        passwordSeparatorView = factorySeparatorView()
        
        addSubview(inputsView)
        setupInputsView()
        
        addSubview(registerLoginBtn)
        setupRegisterBtn()
        
        addSubview(segmentedControl)
        setupSegmentedControl()
        
        addSubview(profileImgView)
        setupProfileImgView()
        
        backgroundColor = UIColor(r: 94, g: 128, b: 191)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupView(view: UIView){
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func factoryTxtField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        if placeholder.lowercased() == "password" {
            tf.isSecureTextEntry = true
        } else if placeholder.lowercased() == "email" {
            tf.keyboardType = UIKeyboardType.emailAddress
        }
        
        return tf
    }
    
    private func factorySeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private func setupSegmentedControl(){
        // Constraints: x, y
        segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        // Constraints: width, height
        segmentedControl.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    private func setupProfileImgView(){
        // Constraints: x, y
        profileImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImgView.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -12).isActive = true
        // Constraints: width, height
        profileImgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupRegisterBtn(){
        // Constraints: width, height
        registerLoginBtn.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerLoginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Constraints: x, y
        registerLoginBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerLoginBtn.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
    }
    
    var inputsViewHeightConstraint: NSLayoutConstraint?
    
    func setupInputsView() {
        // Constraints: x, y
        inputsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // Constraints: width, height
        inputsView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32).isActive = true
        inputsViewHeightConstraint = inputsView.heightAnchor.constraint(equalToConstant: 100)
        inputsViewHeightConstraint?.isActive = true
        
        inputsView.addSubview(nameTxtField)
        setupNameTF()
        
        inputsView.addSubview(emailSeparatorView)
        setupEmailSeparatorView()
        
        inputsView.addSubview(emailTxtField)
        setupEmailTF()
        
        inputsView.addSubview(passwordSeparatorView)
        setupPasswordSeparatorView()
        
        inputsView.addSubview(passwordTxtField)
        setupPasswordTF()
        
        nameTxtField.isHidden = true
        emailSeparatorView.isHidden = true
    }
    
    func setupEmailSeparatorView(){
        // Cosntraints: x, y
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: nameTxtField.bottomAnchor).isActive = true
        // Constraints: width, height
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupPasswordSeparatorView(){
        // Cosntraints: x, y
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor).isActive = true
        // Constraints: width, height
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
    }
    
    func setupNameTF() {
        // Constraints: x, y
        nameTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        nameTxtField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        // Constraints: width, height
        nameTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    var emailHeightConstraint: NSLayoutConstraint?
    var emailTopConstraint: NSLayoutConstraint?
    
    func setupEmailTF() {
        // Constraints: x, y
        emailTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTopConstraint = emailTxtField.topAnchor.constraint(equalTo: nameTxtField.topAnchor)
        emailTopConstraint?.isActive = true
        // Constraints: width, height
        emailTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailHeightConstraint = emailTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2)
        emailHeightConstraint?.isActive = true
    }
    
    var passwordHeightConstraint: NSLayoutConstraint?
    
    func setupPasswordTF() {
        // Constraints: x, y
        passwordTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTxtField.topAnchor.constraint(equalTo: passwordSeparatorView.bottomAnchor).isActive = true
        // Constraints: width, height
        passwordTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordHeightConstraint = passwordTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2)
        passwordHeightConstraint?.isActive = true
    }
    
    func clearLoginUI(){
        nameTxtField.text = ""
        emailTxtField.text = ""
        passwordTxtField.text = ""
        profileImgView.image = UIImage(named: CAMERA_IMG)
    }
}

extension UIColor {
    convenience init(r: CGFloat, g:CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
