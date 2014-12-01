//
//  EmojiSelectionOption.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/28/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelectionOption: SelectionOption {
    var emoji: String
    
    init(controller: EmojiSelectionController, emoji: String) {
        self.emoji = emoji
        super.init(controller: controller)
    }
    
    override func selected() -> Void {
        self.controller.finalSelect(self)
    }
    
    override func addContent(contentView: UIView) {
        let label = UILabel()
        label.text = self.emoji
        label.font = UIFont.systemFontOfSize(100)
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(label)
        
        let constraints = [
            NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self.parentView!,
                attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self.parentView!,
                attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: self.parentView!,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: self.parentView!,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
        ]
        self.parentView.addConstraints(constraints)
    }
}
