//
//  User.swift
//  Messager
//
//  Created by Spencer Forrest on 15/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class User: NSObject {
    private var _name: String!
    private var _email: String!
    private var _imgURL: String?
    private var _uid: String?
    
    var uid: String? {
        get{
            return _uid
        }
        set{
            _uid = newValue
        }
    }
    
    var imgURL: String? {
        get{
            return _imgURL
        }
        set{
            _imgURL = newValue
        }
    }
    
    var name: String {
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    
    var email: String {
        get{
            return _email
        }
        set{
            _email = newValue
        }
    }
}
