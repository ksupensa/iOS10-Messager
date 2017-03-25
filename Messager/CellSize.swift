//
//  CellSize.swift
//  Messager
//
//  Created by Spencer Forrest on 23/03/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit

/// Class with CGSize and NSAttributedString:
///  ## DO NOT INSTANTIATE DIRECTLY:
/// * Use 'CellSize.getCellSizeToFitText(_String:CGFloat:)' instead
class CellSize {
    
    var size: CGSize!
    var attributedString: NSAttributedString!
    
    init(cgSize: CGSize, attrString: NSAttributedString) {
        size = cgSize
        attributedString = attrString
    }
    
    /// Calculate the perfect size for UITextView
    ///
    /// - Parameters:
    ///   - txt: text that will be in the UITextView
    ///   - maxWidth: Maximum width authorized
    /// - Returns: Perfect CellSize
    static func getCellSizeToFitText(_ txt: String, maxWidth: CGFloat) -> CellSize {
        
        // Set up attributes for String
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let FONT = UIFont(name: FONT_NAME, size: FONT_SIZE)!
        let attr: [String: Any] = [NSFontAttributeName: FONT, NSParagraphStyleAttributeName: paragraphStyle]
        
        // Create Attributed String
        let text = NSAttributedString(string: txt, attributes: attr)
        
        // Put Attributed String in the TextView
        let textView = UITextView()
        textView.attributedText = text
        
        // Get the perfect size to fit the Attributed String into TextView
        let max = CGFloat(MAX_FLOAT)
        let size = textView.sizeThatFits(CGSize(width: maxWidth, height: max))
        
        let cellSize = CellSize(cgSize: size, attrString: text)
        
        // Return the perfect "CellSize"
        return cellSize
    }
}
