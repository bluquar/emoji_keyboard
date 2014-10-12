//
//  KBButton.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KBButton: NSObject {
    
    var parentView: UIView
    var layoutManager: ButtonLayoutManager
    var button: UIButton
    var image: UIImageView
    var container: UIView
    var id: Int
    
    init(view: UIView, layoutManager: ButtonLayoutManager) {
        self.parentView = view
        self.id = -1
        self.layoutManager = layoutManager
        
        self.button = UIButton.buttonWithType(.System) as UIButton
        self.button.setTitle("", forState: .Normal)
        self.button.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.button.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        self.button.layer.cornerRadius = 5
        
        self.image = UIImageView()
        self.image.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.container = UIView()
        
        super.init()
    }
    
    func addToLayout(id: Int) {
        self.id = id
        
        // add a callback
        self.button.addTarget(self, action: "touchupinside:", forControlEvents: .TouchUpInside)
        self.button.addTarget(self, action: "touchup:", forControlEvents: .TouchUpOutside)
        self.button.addTarget(self, action: "touchdown:", forControlEvents: .TouchDown)
        
        // layout config
        self.parentView.addSubview(self.container)
        self.container.addSubview(self.button)
        self.container.addSubview(self.image)

        self.button.setTranslatesAutoresizingMaskIntoConstraints(false)
        // pin button to view
        self.parentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .Width, relatedBy: .Equal, toItem: self.container, attribute: .Width, multiplier: 1.0, constant: -5.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .CenterX, relatedBy: .Equal, toItem: self.container, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .Height, relatedBy: .Equal, toItem: self.container, attribute: .Height, multiplier: 1.0, constant: -6.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.button, attribute: .CenterY, relatedBy: .Equal, toItem: self.container, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        self.image.setTranslatesAutoresizingMaskIntoConstraints(false)
        // pin image to view
        self.parentView.addConstraint(NSLayoutConstraint(item: self.image, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: self.container, attribute: .Width, multiplier: 1.0, constant: -7.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.image, attribute: .CenterX, relatedBy: .Equal, toItem: self.container, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.image, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.container, attribute: .Height, multiplier: 1.0, constant: -8.0))
        self.parentView.addConstraint(NSLayoutConstraint(item: self.image, attribute: .CenterY, relatedBy: .Equal, toItem: self.container, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        
        self.parentView.addConstraint(NSLayoutConstraint(item: self.container, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.container, attribute: .Width, multiplier: 0.7, constant: 0.0))
    }
    
    func touchup(sender: AnyObject) {
        self.button.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
        self.image.alpha = 1.0
    }
    
    func touchdown(sender: AnyObject) {
        self.button.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        self.image.alpha = 0.7
    }
    
    func touchupinside(sender: AnyObject) {
        self.touchup(sender)
        self.layoutManager.tapped(self.id)
    }
}
