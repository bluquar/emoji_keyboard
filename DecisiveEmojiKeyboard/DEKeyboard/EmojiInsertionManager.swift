//
//  EmojiInsertionManager.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiInsertionManager: NSObject, EmojiInserter {
   
    var proxy: UITextDocumentProxy
    
    init(proxy: UITextDocumentProxy) {
        self.proxy = proxy
    }
    
    func insertEmoji(emoji: String) -> Void {
        self.proxy.insertText(emoji)
    }
    
}
