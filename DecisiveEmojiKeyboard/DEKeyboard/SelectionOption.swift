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
    var contentView: UIView!
    var parentView: UIView!
    var button: UIButton!
    
    init(controller: EmojiSelectionController) {
        self.controller = controller
    }
    
    func selected() -> Void {
        fatalError("Abstract method")
    }
    
    func addContent(contentView: UIView) -> () {
        fatalError("Abstract method")
    }
    
    func populateView(view: UIView) -> Void {
        self.configureContentView(view)
        self.addContent(self.contentView)
        self.addButton()
    }
    
    func detach() -> Void {
        self.contentView.removeFromSuperview()
        self.contentView = nil
    }
    
    func touchDown(sender: AnyObject) {
        self.button.backgroundColor = DE.buttonColorPressed
    }
    
    func touchUp(sender: AnyObject) {
        self.button.backgroundColor = DE.buttonColorDefault
    }
    
    func touchUpInside(sender: AnyObject) {
        self.touchUp(sender)
        self.selected()
    }
    
    func addButton() -> () {
        self.button = UIButton()
        self.button.addTarget(self, action: "touchDown:", forControlEvents: .TouchDown)
        self.button.addTarget(self, action: "touchUp:", forControlEvents: .TouchUpOutside)
        self.button.addTarget(self, action: "touchUpInside:", forControlEvents: .TouchUpInside)
        
        parentView.addSubview(self.button)
        self.button.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.button.backgroundColor = DE.buttonColorDefault
        self.button.layer.cornerRadius = 10
        
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: parentView, attribute: .CenterX, relatedBy: .Equal, toItem: self.button, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: parentView, attribute: .CenterY, relatedBy: .Equal, toItem: self.button, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: parentView, attribute: .Width, relatedBy: .Equal, toItem: self.button, attribute: .Width, multiplier: 1.0, constant: 4.0),
            NSLayoutConstraint(item: parentView, attribute: .Height, relatedBy: .Equal, toItem: self.button, attribute: .Height, multiplier: 1.0, constant: 4.0)
        ]
        self.parentView.addConstraints(constraints)
    }
    
    func configureContentView(parentView: UIView) -> () {
        self.contentView = UIView()
        
        parentView.addSubview(self.contentView)
        self.contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: parentView, attribute: .CenterX, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: parentView, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: parentView, attribute: .Width, relatedBy: .Equal, toItem: self.contentView, attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: parentView, attribute: .Height, relatedBy: .Equal, toItem: self.contentView, attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        parentView.addConstraints(constraints)
        self.parentView = parentView
    }
}