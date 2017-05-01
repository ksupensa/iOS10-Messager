//
//  Constants.swift
//  Messager
//
//  Created by Spencer Forrest on 13/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import Foundation
import Firebase

let DB_REF = FIRDatabase.database().reference()

let USR = "users"
let EMAIL = "email"
let NAME = "name"
let IMG_URL = "imgURL"
let MESSAGE = "messages"
let TEXT = "text"
let SENDER = "sender"
let RECEIVER = "receiver"
let TIME = "timeStamp"
let USR_MSG = "user-messages"
let IMG_MSG = "image-messages"

let CAMERA_IMG = "camera"
let ICON_SIZE: CGFloat = 56

let FONT_NAME = "Avenir"
let FONT_SIZE: CGFloat = 15

let SENDV_HEIGHT: CGFloat = 50

let MAX_FLOAT = Float.greatestFiniteMagnitude
