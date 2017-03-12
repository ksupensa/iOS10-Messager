//
//  LoginVC.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
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
    
    let nameTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let emailTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let passwordSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTxtField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let profileImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "camera")
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private func createTxtField(placeholder: String) -> UITextField {
       return UITextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(inputsView)
        setupInputsView()
        
        view.addSubview(registerBtn)
        setupRegisterBtn()
        
        view.addSubview(profileImgView)
        setupProfileImgView()
        
        view.backgroundColor = UIColor(r: 175, g: 189, b: 212)
    }
    
    private func setupProfileImgView(){
        // Constraints: x, y
        profileImgView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
        registerBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerBtn.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        // Font + Color
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.titleLabel?.font = UIFont(name: "Avenir", size: 16)
    }
    
    private func setupInputsView() {
        // Constraints: x, y
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Constraints: width, height
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -32).isActive = true
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r: CGFloat, g:CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
