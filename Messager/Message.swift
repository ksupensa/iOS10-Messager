//
//  Message.swift
//  Messager
//
//  Created by Spencer Forrest on 18/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class Message: NSObject {
    private var _receiver: String!
    private var _text: String?
    private var _sender: String!
    private var _timeStamp: String!
    private var _imgURL: String?
    
    var imgURL: String? {
        get {
            return _imgURL
        }
        set {
            _imgURL = newValue
        }
    }
    
    var sender: String {
        get {
            return _sender
        }
        set {
            _sender = newValue
        }
    }
    
    var text: String? {
        get {
            return _text
        }
        set {
            _text = newValue
        }
    }
    
    var receiver: String {
        get {
            return _receiver
        }
        set {
            _receiver = newValue
        }
    }
    
    var timeStamp: String {
        get {
            return _timeStamp
        }
        set {
            _timeStamp = newValue
        }
    }
}
