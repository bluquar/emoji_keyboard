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
        self.buttonLayoutManager = ButtonLayoutManager(settings: self.settings)
        self.emojiSelectionController = EmojiSelectionController(buttonManager: self.buttonLayoutManager)
        super.init()
        self.buttonLayoutManager.kbDelegate! = self
    }

    required init(coder aDecoder: NSCoder) {
        self.settings = SettingsManager()
        self.buttonLayoutManager = ButtonLayoutManager(settings: self.settings)
        self.emojiSelectionController = EmojiSelectionController(buttonManager: self.buttonLayoutManager)
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        self.settings = SettingsManager()
        self.buttonLayoutManager = ButtonLayoutManager(settings: self.settings)
        self.emojiSelectionController = EmojiSelectionController(buttonManager: self.buttonLayoutManager)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.buttonLayoutManager.kbDelegate = self
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.buttonLayoutManager.updateViewConstraints()
    }

    func insertText(emoji: String) -> Void {
        (self.textDocumentProxy as UITextDocumentProxy).insertText(emoji)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonLayoutManager.viewDidLoad(self.view)
        self.emojiSelectionController.viewDidLoad(self)
    }
}
