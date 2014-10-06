//
//  EmojiSelectionController.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/5/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelectionController: NSObject {
    
    let maxSelections: Int = 6
    var numSelections: Int
    
    override init() {
        self.numSelections = 0
        super.init()
    }
    
    func setInitialButtons(layoutManager: ButtonLayoutManager) {
        
    }
    
}
