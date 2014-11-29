//
//  TouchListener.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/28/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class TouchListener: NSObject {
    
    var row: Int
    var col: Int
    var cell: UIControl
    var controller: ButtonLayoutManager
    
    func addListeners() -> () {
        self.cell.addTarget(self, action: "touchupinside:", forControlEvents: .TouchUpInside)
        self.cell.addTarget(self, action: "touchup:", forControlEvents: .TouchUpOutside)
        self.cell.addTarget(self, action: "touchdown:", forControlEvents: .TouchDown)
    }
    
    func touchdown(sender: AnyObject) {
        self.cell.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    }
    
    func touchup(sender: AnyObject) {
        self.cell.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
    }
    
    func touchupinside(sender: AnyObject) {
        self.touchup(sender)
        self.controller.selected(row, col: col)
    }
    
    init(controller: ButtonLayoutManager, cell: UIControl, row: Int, col: Int) {
        self.controller = controller
        self.cell = cell
        self.row = row
        self.col = col
        super.init()
        self.addListeners()
    }
}
