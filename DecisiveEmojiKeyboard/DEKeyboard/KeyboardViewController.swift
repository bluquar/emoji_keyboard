//
//  KeyboardViewController.swift
//  DEKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var buttonLayoutManager : ButtonLayoutManager
    var emojiSelectionController: EmojiSelectionController
    var settings: SettingsManager

    override init() {
        self.settings = SettingsManager()
        self.emojiSelectionController = EmojiSelectionController
        self.buttonLayoutManager = ButtonLayoutManager(self.emojiSelectionController!, self, self.settings!)
        super.init()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.buttonLayoutManager.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inserter = EmojiInsertionManager(self.textDocumentProxy as UITextDocumentProxy)
        self.buttonLayoutManager.viewDidLoad(self.view, inserter)
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
    }

}
