//
//  Caching.swift
//  Messager
//
//  Created by Spencer Forrest on 17/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

let imageCache: NSCache<NSString, UIImage> = NSCache()

extension UIImageView {
    func loadImgFromCache(_ vc: UIViewController, imgUrl: String) {
        
        // Get the image from Cache
        if let cachedImg = imageCache.object(forKey: NSString(string: imgUrl)) {
            self.image = cachedImg
            return
        }
        
        // Get the image from Network
        if let url = URL(string: imgUrl) {
            URLSession.shared.dataTask(with: url) {
                (dataByte: Data?, response: URLResponse?, error: Error?) in
                if let err = error {
                    print("spencer: Downloading image error - \(err.localizedDescription)")
                    return
                }

                if let data = dataByte {
                    DispatchQueue.main.async {
                        if let downloadedImg = UIImage(data: data) {
                            imageCache.setObject(downloadedImg, forKey: NSString(string: imgUrl))
                            self.image = downloadedImg
                        }
                    }
                } else {
                    print("spencer: Downloading image error - Invalid data")
                }
            }.resume()
        } else {
            print("spencer: Illegal imgURL format")
        }
    }
}
