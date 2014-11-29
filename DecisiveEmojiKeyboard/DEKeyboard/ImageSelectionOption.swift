//
//  ImageSelectionOption.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/26/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class ImageSelectionOption: SelectionOption {
    var score: EmojiScore
    var path: String
    var image: UIImage?
    
    init(controller: EmojiSelectionController, path: String, score: EmojiScore) {
        self.path = path
        self.score = score
        super.init(controller: controller)
    }
    
    override func selected() -> Void {
        self.controller.incrementalSelect(self)
    }
    
    override func populateView(view: UIView) -> Void {
        // add an activity spinner thing if it hasn't loaded yet, and the image otherwise
    }

}
/*
import UIKit

class KBButton: NSObject {

var parentView: UIView
var layoutManager: ButtonLayoutManager
var button: UIButton
var image: UIImageView
var container: UIView
var row: Int
var col: Int

init(view: UIView, layoutManager: ButtonLayoutManager) {
self.parentView = view
self.layoutManager = layoutManager
self.row = -1
self.col = -1

self.button = UIButton.buttonWithType(.System) as UIButton
self.button.setTitle("", forState: .Normal)
self.button.titleLabel?.font = UIFont.systemFontOfSize(14)
self.button.backgroundColor = UIColor(white: 0.9, alpha: 0.5)
self.button.layer.cornerRadius = 5

self.image = UIImageView()
self.image.contentMode = UIViewContentMode.ScaleAspectFit

self.container = UIView()

super.init()
}
*/