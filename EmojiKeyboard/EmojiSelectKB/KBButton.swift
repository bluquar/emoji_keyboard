//
//  KBButton.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KBButton: NSObject {
    class func generateButton(#title: String) -> UIButton {
        var button = UIButton.buttonWithType(.System) as UIButton
        button.setTitle(title, forState: .Normal)
        
        button.sizeToFit()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //button.titleLabel!.font = UIFont(name: "MarkerFelt-Thin", size: 32)
        
        button.backgroundColor = UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        // button.layer : CALayer (tweak minor UI things)
        button.layer.cornerRadius = 5
        
        
        
        return button
    }
}
