//
//  KeyboardViewController.swift
//  EmojiSelectKB
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var buttons: NSArray!
    
    var someButton: UIButton!
    var anotherButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    func initializeButtons() {
        // nsarray of buttons
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawNextKeyboardButton()
        self.initializeButtons()
        self.drawSomeButton()
        self.drawAnotherButton()
    }
    
    func drawSomeButton() {
        self.someButton = KBButton.generateButton(title: "🚀")
        self.someButton.addTarget(self, action: "displayTitle:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.someButton)
        
        var buttonCenterX = NSLayoutConstraint(item: self.someButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        var buttonCenterY = NSLayoutConstraint(item: self.someButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([buttonCenterX, buttonCenterY])
        
        
    }
    
    func drawAnotherButton() {
        self.anotherButton = KBButton.generateButton(title: "bitches")
        self.anotherButton.addTarget(self, action: "displayTitle:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.someButton)
        
        var buttonCenterX = NSLayoutConstraint(item: self.someButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        var buttonCenterY = NSLayoutConstraint(item: self.someButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([buttonCenterX, buttonCenterY])
        
        
    }
    
    func displayTitle(sender: UIButton) {
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        proxy.insertText(sender.titleLabel!.text!)
    }
    
    func drawNextKeyboardButton() {
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        
        
        
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.nextKeyboardButton.addTarget(self, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        
        // nextKeyboardButton.left = self.view.left * 1.0 + 0.0
        var nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: 0.0)
        var nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        var proxy = self.textDocumentProxy as UITextDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }


}
