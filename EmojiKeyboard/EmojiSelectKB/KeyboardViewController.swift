//
//  KeyboardViewController.swift
//  EmojiSelectKB
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController /* ButtonLayoutDelegate */ {
    
    // model/view delegates
    var buttonLayoutManager : ButtonLayoutManager!
    var emojiSelectionController: EmojiSelectionController!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emojiSelectionController = EmojiSelectionController()
        self.buttonLayoutManager = ButtonLayoutManager(view: self.view, proxy: self.textDocumentProxy as UITextDocumentProxy, buttonSource: self.emojiSelectionController, kbdelegate: self)
        self.buttonLayoutManager.initializeButtons()
    }
    
    func didTapDot() {
        var proxy = textDocumentProxy as UITextDocumentProxy
        
        proxy.insertText(".")
    }
    
    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput) {
        // The app has just changed the document's contents, the document context has been updated.
        
    }


}
