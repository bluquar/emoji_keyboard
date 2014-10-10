//
//  KeyboardViewController.swift
//  EmojiSelectKB
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController /* ButtonLayoutDelegate */ {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    var buttonLayoutManager : ButtonLayoutManager!
    var emojiSelectionController: EmojiSelectionController!
    
    
    var customInterface: UIView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        var nib = UINib(nibName: "CustomKeyboardInterface", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        customInterface = objects[0] as UIView
    }

    override init() {
        super.init()
        
        var nib = UINib(nibName: "CustomKeyboardInterface", bundle: nil)
        let objects = nib.instantiateWithOwner(self, options: nil)
        customInterface = objects[0] as UIView
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawNextKeyboardButton()
        view.addSubview(customInterface)
        
        /*self.drawNextKeyboardButton()
        
        self.emojiSelectionController = EmojiSelectionController()
        self.buttonLayoutManager = ButtonLayoutManager(view: self.view, buttonSource: self.emojiSelectionController)*/
        
        //self.manualSelectionController = ManualSelectionController(self.buttonLayoutManager)
    }
    
    @IBAction func tappedTestButton() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("test button")
    }
    
    override func viewDidLayoutSubviews() {
        //self.view.frame = CGRect(x:0, y:0, width:400, height:200)
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
        // self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
    }


}
