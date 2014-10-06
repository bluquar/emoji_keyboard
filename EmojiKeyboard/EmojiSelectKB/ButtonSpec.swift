//
//  ButtonSpec.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/5/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class ButtonSpec: NSObject {
   
    var icon: UIImage
    var onPress: Void -> Void
    
    init(icon: UIImage, onPress: Void -> Void) {
        self.icon = icon
        self.onPress = onPress
    }
    
    convenience init(iconPath: String, onPress: Void -> Void) {
        var img: UIImage = UIImage(named: iconPath)
        self.init(icon: img, onPress)
    }
}
