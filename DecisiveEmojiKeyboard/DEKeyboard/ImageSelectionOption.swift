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
    
    var label: UILabel?
    var imageView: UIImageView?
    var isDisplaying: Bool
    
    init(controller: EmojiSelectionController, path: String, score: EmojiScore) {
        self.path = path
        self.score = score
        self.isDisplaying = false
        super.init(controller: controller)
    }
    
    override func selected() -> Void {
        self.controller.incrementalSelect(self)
    }
    
    override func detach() {
        self.isDisplaying = false
        self.label = nil
        self.imageView = nil
        super.detach()
    }
    
    func clearViews() -> () {
        if self.imageView != nil {
            self.imageView!.removeFromSuperview()
        }
        if self.label != nil {
            self.label!.removeFromSuperview()
        }
    }
    
    func addLabel() -> () {
        self.clearViews()
        var label = UILabel()
        label.text = path
        label.font = UIFont.systemFontOfSize(50)
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(label)
        
        let constraints = [
            NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: contentView,
                attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: contentView,
                attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: contentView,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: contentView,
                attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        contentView.addConstraints(constraints)
        contentView.layoutSubviews()
    }
    
    func addImage() -> () {
        var img = self.image!
        var imgView = UIImageView(image: img)
        imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(imgView)
        self.imageView = imgView
        
        let constraints = [
            NSLayoutConstraint(item: imgView, attribute: .CenterX, relatedBy: .Equal, toItem: contentView,
                attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .CenterY, relatedBy: .Equal, toItem: contentView,
                attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .Width, relatedBy: .Equal, toItem: contentView,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .Height, relatedBy: .Equal, toItem: contentView,
                attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        contentView.addConstraints(constraints)
        contentView.layoutSubviews()
    }
    
    override func addContent(contentView: UIView) {
        self.isDisplaying = true
        self.clearViews()
        if self.image == nil {
            self.addLabel()
        } else {
            self.addImage()
        }
    }
    
    func async_load() -> () {
        let path = self.path
        let queue = NSOperationQueue()
        queue.addOperationWithBlock() {
            let img = UIImage(contentsOfFile: path)
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                self.image = img
                if self.image != nil {
                    if self.isDisplaying {
                        self.clearViews()
                        self.addImage()
                    }
                }
            }
        }
    }
}
