//
//  LoginC.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class LoginC: UIViewController {
    weak var delegate: RecentD?
    
    internal var login = true
    internal var lv = LoginV()
    
    private var btn: UIButton!
    private var sc: UISegmentedControl!
    internal var img: UIImageView!
    internal var hasDefaultImg: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(lv)
        
        btn = lv.registerLoginBtn
        sc = lv.segmentedControl
        img = lv.profileImgView
        
        lv.setupView(view: view)
        setupActions()
    }
    
    internal func setupActions(){
        sc.addTarget(self, action: #selector(segmentControlChanged), for: UIControlEvents.valueChanged)
        btn.addTarget(self, action: #selector(registerBtnTapped), for: UIControlEvents.touchUpInside)
        // Profile Image
        img.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImgTapped)))
        img.isUserInteractionEnabled = true
    }
    
    // Transfert Name back to previous delegate
    func login(_ name: String?) {
        delegate?.transferName(name, completed: {
            self.lv.clearLoginUI()
            self.hasDefaultImg = true
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
