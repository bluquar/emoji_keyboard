//
//  ButtonLayoutManager.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class ButtonLayoutManager: NSObject {
    
    var buttonSource: EmojiSelectionController
    var view: UIView
    var kbDelegate: KeyboardViewController
    
    var nextKeyboardButton: UIButton!
    var dotButton: UIButton!
    
    var quadrants: [Int: KBButton]
    var proxy: UITextDocumentProxy
    
    init(view: UIView, proxy: UITextDocumentProxy, buttonSource: EmojiSelectionController,
        kbdelegate: KeyboardViewController) {
            self.buttonSource = buttonSource
            self.proxy = proxy
            self.view = view
            self.quadrants = Dictionary<Int, KBButton>()
            self.kbDelegate = kbdelegate
            super.init()
            
            buttonSource.viewDelegate = self
    }
    
    func initializeButtons() {
        self.initializeNextKBbutton()
        //self.initializeDotButton()
        self.initializeQuadrants()
    }
    
    func initializeNextKBbutton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self.kbDelegate, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    func initializeQuadrants() {
        self.quadrants = [
            0: KBButton(view: self.view, layout: KBLayout(horizSelf: .Left, horizParent: .Left, horizRelation: .LessThanOrEqual, horizConstant: 15.0, vertSelf: .Top, vertParent: .Top, vertRelation: .LessThanOrEqual, vertConstant: 15.0), layoutManager: self),
            1: KBButton(view: self.view, layout: KBLayout(horizSelf: .Right, horizParent: .Right, horizRelation: .GreaterThanOrEqual, horizConstant: -15.0, vertSelf: .Top, vertParent: .Top, vertRelation: .LessThanOrEqual, vertConstant: 15.0), layoutManager: self),
            2: KBButton(view: self.view, layout: KBLayout(horizSelf: .Left, horizParent: .Left, horizRelation: .LessThanOrEqual, horizConstant: 15.0, vertSelf: .Bottom, vertParent: .Bottom, vertRelation: .GreaterThanOrEqual, vertConstant: -35.0), layoutManager: self),
            3: KBButton(view: self.view, layout: KBLayout(horizSelf: .Right, horizParent: .Right, horizRelation: .GreaterThanOrEqual, horizConstant: -15.0, vertSelf: .Bottom, vertParent: .Bottom, vertRelation: .LessThanOrEqual, vertConstant: -35.0), layoutManager: self),
        ]
        
        for (id, quad) in self.quadrants {
            quad.addToLayout(id)
        }
        
        /*self.topRightButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: self.view.frame.width/4, translationY: -self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)
        
        self.bottomLeftButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: -self.view.frame.width/4, translationY: self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)
        
        self.bottomRightButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: self.view.frame.width/4, translationY: self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)*/
        
        //self.view.layoutSubviews()
        
        self.buttonSource.setInitialButtons(self)
    }
    
    func tapped(id: Int) {
        self.buttonSource.updateButtons(self, id: id)
    }
    
    func updateButton(text: String, rows: Int, id: Int) {
        self.quadrants[id]?.button.titleLabel?.numberOfLines = rows
        self.quadrants[id]?.button.setTitle(text, forState: .Normal)
        self.quadrants[id]?.button.sizeToFit()
    }
}
