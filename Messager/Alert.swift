//
//  Alert.swift
//  Messager
//
//  Created by Spencer Forrest on 14/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

class Alert {
    static func message(_ vc: UIViewController, title: String, message: String, buttonTitle: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.cancel,handler: nil))
        
        vc.present(alertController, animated: true, completion: nil)
    }
}
