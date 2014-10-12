//
//  ButtonLayoutManager.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

protocol ButtonSource {
    func updateState(id: Int) -> String?
    func updateButtons(layoutManager: ButtonLayoutManager) -> Void
}

class ButtonLayoutManager: NSObject {
    
    var buttonSource: ButtonSource
    var view: UIView
    var kbDelegate: KeyboardViewController
    
    var nextKeyboardButton: UIButton!
    var quadrants: [Int: KBButton]
    var insertionLabel: UILabel!
    
    var proxy: UITextDocumentProxy
    
    let insertionLabelOpacityDecrement: CGFloat = 0.04
    let insertionLabelOpacityTimeDelta: UInt64 = 25 * NSEC_PER_MSEC
    let insertionLabelOpacityStart: CGFloat = 0.6
    
    init(view: UIView, proxy: UITextDocumentProxy, buttonSource: EmojiSelectionController,
        kbdelegate: KeyboardViewController) {
            self.buttonSource = buttonSource
            self.proxy = proxy
            self.view = view
            self.quadrants = Dictionary<Int, KBButton>()
            self.kbDelegate = kbdelegate
            super.init()
    }
    
    func initializeButtons() {
        self.initializeNextKBbutton()
        self.initializeQuadrants()
    }
    
    func initializeNextKBbutton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self.kbDelegate, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 5.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint])
    }
    
    func initializeQuadrants() {
        self.quadrants = [
            0: KBButton(view: self.view, layoutManager: self),
            1: KBButton(view: self.view, layoutManager: self),
            2: KBButton(view: self.view, layoutManager: self),
            3: KBButton(view: self.view, layoutManager: self),
        ]
        
        for (id, quad) in self.quadrants {
            quad.addToLayout(id)
        }
        
        self.insertionLabel = UILabel()
        self.insertionLabel?.text = "∆"
        self.insertionLabel?.alpha = 0.0
        self.insertionLabel?.font = UIFont.systemFontOfSize(175)
        self.view.addSubview(self.insertionLabel!)
        self.insertionLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.updateConstraints()
        self.view.layoutSubviews()
        self.buttonSource.updateButtons(self)
    }
    
    func updateConstraints() {
        let topLeft: UIView = self.quadrants[0]!.container
        let topRight: UIView = self.quadrants[1]!.container
        let bottomLeft: UIView = self.quadrants[2]!.container
        let bottomRight: UIView = self.quadrants[3]!.container
        
        topLeft.setTranslatesAutoresizingMaskIntoConstraints(false)
        topRight.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomLeft.setTranslatesAutoresizingMaskIntoConstraints(false)
        bottomRight.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constraints = [
            NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -10.0),
            // Anchor the top left button to the top left
            NSLayoutConstraint(item: topLeft, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint(item: topLeft, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0),
            // Anchor the top right button to the top right
            NSLayoutConstraint(item: topRight, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: 10.0),
            NSLayoutConstraint(item: topRight, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0),
            // Anchor the bottom left button to the bottom left
            NSLayoutConstraint(item: bottomLeft, attribute: .Bottom, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute: .Top, multiplier: 1.0, constant: -10.0),
            NSLayoutConstraint(item: bottomLeft, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 10.0),
            // Anchor the bottom right button to the bottom right
            NSLayoutConstraint(item: bottomRight, attribute: .Bottom, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute: .Top, multiplier: 1.0, constant: -10.0),
            NSLayoutConstraint(item: bottomRight, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -10.0),
            // Anchor the top left to the bottom right
            NSLayoutConstraint(item: topLeft, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLeft, attribute: .Top, multiplier: 1.0, constant: -10.0),
            // Anchor the top left to the top right
            NSLayoutConstraint(item: topLeft, attribute: .Right, relatedBy: .Equal, toItem: topRight, attribute: .Left, multiplier: 1.0, constant: -10.0),
            // Anchor the top right to the bottom right
            NSLayoutConstraint(item: topRight, attribute: .Bottom, relatedBy: .Equal, toItem: bottomRight, attribute: .Top, multiplier: 1.0, constant: -10.0),
            // Anchor the bottom left to the bottom right
            NSLayoutConstraint(item: bottomLeft, attribute: .Right, relatedBy: .Equal, toItem: bottomRight, attribute: .Left, multiplier: 1.0, constant: -10.0),
            // Set up the insertion label
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        // assert all widths and heights are equal
        for other in [topRight, bottomLeft, bottomRight] {
            constraints.append(NSLayoutConstraint(item: topLeft, attribute: .Height, relatedBy: .Equal, toItem: other, attribute: .Height, multiplier: 1.0, constant: 0.0))
            constraints.append(NSLayoutConstraint(item: topLeft, attribute: .Width, relatedBy: .Equal, toItem: other, attribute: .Width, multiplier: 1.0, constant: 0.0))
        }
        
        self.view.addConstraints(constraints)
    }
    
    func diminishInsertionLabel() {
        if (self.insertionLabel!.alpha < self.insertionLabelOpacityDecrement) {
            self.insertionLabel!.alpha = 0.0
        } else {
            self.insertionLabel!.alpha -= self.insertionLabelOpacityDecrement
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.insertionLabelOpacityTimeDelta))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.diminishInsertionLabel()
            })
        }
    }
    
    func showInsertionLabel(c: String) {
        self.insertionLabel!.text = c
        self.insertionLabel!.alpha = self.insertionLabelOpacityStart + self.insertionLabelOpacityDecrement
        self.diminishInsertionLabel()
    }
    
    func tapped(id: Int) {
        let char = self.buttonSource.updateState(id)
        if (char != nil) {
            self.showInsertionLabel(char!)
            self.proxy.insertText(char!)
        }
        self.buttonSource.updateButtons(self)
    }
    
    func updateButton(id: Int, image: UIImage) {
        let kbb = self.quadrants[id]!
        kbb.image.image = image
    }
}
