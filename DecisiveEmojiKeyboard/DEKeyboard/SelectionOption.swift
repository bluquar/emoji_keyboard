//
//  SelectionOption.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class SelectionOption: NSObject { // EmojiSelection

    var controller: EmojiSelectionController
    
    init(controller: EmojiSelectionController) {
        self.controller = controller
    }
    
    func selected() -> Void {
        fatalError("Abstract method")
    }
    
    func populateView(view: UIView) -> Void {
        fatalError("Abstract method")
    }
    
    func detach() -> Void {
        // detach self from vew
        fatalError("Abstract method")
    }
}