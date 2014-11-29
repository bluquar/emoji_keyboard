//
//  EmojiSelectionOption.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/28/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelectionOption: SelectionOption {
    var emoji: String
    
    init(controller: EmojiSelectionController, emoji: String) {
        self.emoji = emoji
        super.init(controller: controller)
    }
    
    override func selected() -> Void {
        self.controller.finalSelect(self)
    }
    
    
    override func populateView(view: UIView) -> Void {
        
    }
}
