//
//  LoginView.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class LoginView: UIView {
    
    var nameTxtField: UITextField!
    var emailTxtField: UITextField!
    var passwordTxtField: UITextField!
    
    var emailSeperatorView: UIView!
    var passwordSeperatorView: UIView!
    
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let registerBtn: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.backgroundColor = UIColor(r: 59, g: 89, b: 152)
        button.setTitle("Register", for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    let profileImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "camera")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        passwordTxtField = factoryTxtField(placeholder: "Password")
        emailTxtField = factoryTxtField(placeholder: "Email")
        nameTxtField = factoryTxtField(placeholder: "Name")
        
        emailSeperatorView = factorySeperatorView()
        passwordSeperatorView = factorySeperatorView()
        
        self.addSubview(inputsView)
        setupInputsView()
        
        self.addSubview(registerBtn)
        setupRegisterBtn()
        
        self.addSubview(profileImgView)
        setupProfileImgView()
        
        self.backgroundColor = UIColor(r: 175, g: 189, b: 212)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func factoryTxtField(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }
    
    private func factorySeperatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func setupLoginView(view: UIView){
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupProfileImgView(){
        // Constraints: x, y
        profileImgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileImgView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -40).isActive = true
        // Constraints: width, height
        profileImgView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImgView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func setupRegisterBtn(){
        // Constraints: width, height
        registerBtn.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Constraints: x, y
        registerBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        registerBtn.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        // Font + Color
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 16)
    }
    
    private func setupInputsView() {
        // Constraints: x, y
        inputsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // Constraints: width, height
        inputsView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -32).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsView.addSubview(nameTxtField)
        setupNameTF()
        
        inputsView.addSubview(emailSeperatorView)
        setupEmailSeperatorView()
        
        inputsView.addSubview(emailTxtField)
        setupEmailTF()
        
        inputsView.addSubview(passwordSeperatorView)
        setupPasswordSeperatorView()
        
        inputsView.addSubview(passwordTxtField)
        setupPasswordTF()
        
    }
    
    private func setupEmailSeperatorView(){
        // Cosntraints: x, y
        emailSeperatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeperatorView.topAnchor.constraint(equalTo: nameTxtField.bottomAnchor).isActive = true
        // Constraints: width, height
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
    }
    
    private func setupPasswordSeperatorView(){
        // Cosntraints: x, y
        passwordSeperatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeperatorView.topAnchor.constraint(equalTo: emailTxtField.bottomAnchor).isActive = true
        // Constraints: width, height
        passwordSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordSeperatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
    }
    
    private func setupNameTF() {
        // Constraints: x, y
        nameTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        nameTxtField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        // Constraints: width, height
        nameTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3, constant: 0).isActive = true
    }
    
    private func setupEmailTF() {
        // Constraints: x, y
        emailTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTxtField.topAnchor.constraint(equalTo: emailSeperatorView.bottomAnchor).isActive = true
        // Constraints: width, height
        emailTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3, constant: 0).isActive = true
    }
    
    private func setupPasswordTF() {
        // Constraints: x, y
        passwordTxtField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTxtField.topAnchor.constraint(equalTo: passwordSeperatorView.bottomAnchor).isActive = true
        // Constraints: width, height
        passwordTxtField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTxtField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/3, constant: 0).isActive = true
    }
}
