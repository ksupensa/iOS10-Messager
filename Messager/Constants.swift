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
let STR_REF = FIRStorage.storage().reference()
let AUTH_REF = FIRAuth.auth()
let PROF_IMG_REF = STR_REF.child("profile-img")

let USR = "users"
let EMAIL = "email"
let NAME = "name"
let IMG_URL = "imgURL"
let MESSAGE = "messages"
let TEXT = "text"
let SENDER = "sender"
let RECEIVER = "receiver"
let TIME = "timeStamp"

let CAMERA_IMG = "camera"
let ICON_SIZE: CGFloat = 56
