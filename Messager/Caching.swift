//
//  Caching.swift
//  Messager
//
//  Created by Spencer Forrest on 17/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import Firebase

let imageCache: NSCache<NSString, UIImage> = NSCache()

extension UIImageView {
    func loadImgFromCache(imgUrl: String?) {
        // If no imgUrl, put default image then return
        guard let _ = imgUrl else {
            self.image = UIImage(named: CAMERA_IMG)
            return
        }
        
        // Get the image from Cache
        if let cachedImg = imageCache.object(forKey: NSString(string: imgUrl!)) {
            self.image = cachedImg
            return
        }
        
        // Get the image from Network
        if let url = URL(string: imgUrl!) {
            firebaseDownload(url: url)
        } else {
            print("spencer: Illegal imgURL format")
        }
    }
    
    func firebaseDownload(url: URL){
        // Download image from Firebase
        let ref = FIRStorage.storage().reference(forURL: url.absoluteString)
        ref.data(withMaxSize: 2 * 1024 * 1024, completion: {
            data, error in
            
            if error == nil {
                if let imgData = data {
                    
                    if let downloadedImg = UIImage(data: imgData) {
                        DispatchQueue.main.async {
                            // Update image
                            self.image = downloadedImg
                            // Put image in cache
                            imageCache.setObject(downloadedImg, forKey: NSString(string: url.absoluteString))
                        }
                    }
                }
            } else {
                print("spencer: Failed to Download image - \(String(describing: error?.localizedDescription))")
            }
        })
    }
}
