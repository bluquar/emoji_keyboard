 //
//  ButtonLayoutSpec.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class ButtonLayoutSpec: NSObject {
    var rows: Int
    var cols: Int
    var specs: [[ButtonSpec!]]
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.specs = [[nil, nil], [nil, nil]]
        
        
    }
}
