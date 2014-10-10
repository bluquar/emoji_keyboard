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
    
    var topLeftButton: KBButton!
    var topRightButton: KBButton!
    var bottomLeftButton: KBButton!
    var bottomRightButton: KBButton!
    
    init(view: UIView, buttonSource: EmojiSelectionController) {
        self.buttonSource = buttonSource

        self.view = view
        super.init()

        let a = self.view.frame
        println(a)
        
        self.topLeftButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: -self.view.frame.width/4, translationY: -self.view.frame.height/4, scaleFactor: CGFloat(0.3), layoutManager: self)
        
        /*self.topRightButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: self.view.frame.width/4, translationY: -self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)
        
        self.bottomLeftButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: -self.view.frame.width/4, translationY: self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)
        
        self.bottomRightButton = KBButton(ratingMap: EmojiRatingMap(), imagePath: "kittens.jpg", view: view, translationX: self.view.frame.width/4, translationY: self.view.frame.height/4, scaleFactor: CGFloat(0.4), layoutManager: self)*/
        
        self.view.layoutSubviews()
        
        self.buttonSource.setInitialButtons(self)
        
        
    }
    
    func setButtonConfig(spec: ButtonLayoutSpec) {
        // TODO: Define a protocol for setting button configuration
        // Easiest way to do this:
        //  -> Maintain an instance variable of existing buttons
        //  -> When this method is called, clear out existing buttons
        //  -> Arguments should be passed in a matrix format, i.e.,
        //     [[ButtonSpec, ButtonSpec, ButtonSpec],
        //      [ButtonSpec, ButtonSpec, ButtonSpec]]
        //  -> Then find proper dimensions and add buttons & listeners
    }
}
