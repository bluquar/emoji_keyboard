//
//  KBLayout.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/11/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KBLayout: NSObject {
    
    var horizSelf: NSLayoutAttribute
    var horizParent: NSLayoutAttribute
    var horizRelation: NSLayoutRelation
    var horizConstant: CGFloat
    
    var vertSelf: NSLayoutAttribute
    var vertParent: NSLayoutAttribute
    var vertRelation: NSLayoutRelation
    var vertConstant: CGFloat
    
    init(horizSelf: NSLayoutAttribute, horizParent: NSLayoutAttribute, horizRelation: NSLayoutRelation, horizConstant: CGFloat, vertSelf: NSLayoutAttribute, vertParent: NSLayoutAttribute, vertRelation: NSLayoutRelation, vertConstant: CGFloat) {
        self.horizSelf = horizSelf
        self.horizParent = horizParent
        self.horizRelation = horizRelation
        self.horizConstant = horizConstant
        
        self.vertSelf = vertSelf
        self.vertParent = vertParent
        self.vertRelation = vertRelation
        self.vertConstant = vertConstant
    }
    
    func apply(selfview: UIView, parentview: UIView) {
        let horizontalConstraint = NSLayoutConstraint(item: selfview, attribute: self.horizSelf, relatedBy: self.horizRelation, toItem: parentview, attribute: self.horizParent, multiplier: 1.0, constant: self.horizConstant)
        let verticalConstraint = NSLayoutConstraint(item: selfview, attribute: self.vertSelf, relatedBy: self.vertRelation, toItem: parentview, attribute: self.vertParent, multiplier: 1.0, constant: self.vertConstant)
        parentview.addConstraints([horizontalConstraint, verticalConstraint])
    }

}
