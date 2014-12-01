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
    
    init(controller: EmojiSelectionController, path: String, score: EmojiScore) {
        self.path = path
        self.score = score
        super.init(controller: controller)
    }
    
    override func selected() -> Void {
        self.controller.incrementalSelect(self)
    }
    
    override func detach() {
        self.clearViews()
        super.detach()
    }
    
    func clearViews() -> () {
        if self.imageView != nil {
            self.imageView!.removeFromSuperview()
            self.imageView = nil
        }
        if self.label != nil {
            self.label!.removeFromSuperview()
            self.label!.text = ""
            self.label = nil
        }
    }
    
    func addLabel() -> () {
        var label = UILabel()
        label.text = ""
        label.font = UIFont.systemFontOfSize(50)
        label.textAlignment = NSTextAlignment.Center
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(label)
        
        let constraints = [
            NSLayoutConstraint(item: label, attribute: .CenterX, relatedBy: .Equal, toItem: self.parentView,
                attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .CenterY, relatedBy: .Equal, toItem: self.parentView,
                attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Width, relatedBy: .Equal, toItem: self.parentView,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: label, attribute: .Height, relatedBy: .Equal, toItem: self.parentView,
                attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        self.parentView.addConstraints(constraints)
    }
    
    func addImage() -> () {
        if self.contentView == nil || self.image == nil {
            return
        }
        var img = self.image!
        var imgView = UIImageView(image: img)
        imgView.contentMode = UIViewContentMode.ScaleAspectFit
        imgView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.contentView.addSubview(imgView)
        self.imageView = imgView
        
        let constraints = [
            NSLayoutConstraint(item: imgView, attribute: .CenterX, relatedBy: .Equal, toItem: self.parentView,
                attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .CenterY, relatedBy: .Equal, toItem: self.parentView,
                attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .Width, relatedBy: .Equal, toItem: self.parentView,
                attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: imgView, attribute: .Height, relatedBy: .Equal, toItem: self.parentView,
                attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        self.parentView.addConstraints(constraints)
    }
    
    override func addContent(contentView: UIView) {
        self.clearViews()
        if self.image == nil {
            self.addLabel()
        } else {
            self.addImage()
        }
    }
    
    func load_image(path: String) -> UIImage? {
        return UIImage(named: path)
    }
    
    func async_load() -> () {
        let path = self.path
        let queue = NSOperationQueue()
        queue.addOperationWithBlock() {
            let img = UIImage(named: path)
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                self.image = img
                if self.contentView != nil {
                    self.clearViews()
                    if self.label != nil {
                        self.label!.textColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.0)
                    }
                    self.addImage()
                }
            }
        }
    }
}
