//
//  KBButton.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KBButton: NSObject {
    
    var view: UIView
    var layoutManager: ButtonLayoutManager
    var layout: KBLayout
    var button: UIButton
    var id: Int
    
    init(view: UIView, layout: KBLayout, layoutManager: ButtonLayoutManager) {
            self.view = view
            self.layout = layout
            self.id = -1
            self.layoutManager = layoutManager
            self.button = UIButton.buttonWithType(.System) as UIButton
            self.button.titleLabel?.numberOfLines = 2
            self.button.setTitle("PLACEHOL\nDERRRRRR", forState: .Normal)
            super.init()
    }
    
    func addToLayout(id: Int) {
        self.id = id
        
        // add a callback
        self.button.addTarget(self, action: "tapped:", forControlEvents: .TouchUpInside)
        
        // layout config
        self.button.sizeToFit()
        self.button.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.button.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.button.layer.cornerRadius = 5
        view.addSubview(self.button)
        
        self.layout.apply(self.button, parentview: self.view)
    }
    
    func tapped(sender: UIButton!) {
        self.layoutManager.tapped(self.id)
    }
}
