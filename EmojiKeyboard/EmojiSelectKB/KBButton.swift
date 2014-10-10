//
//  KBButton.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class KBButton: NSObject {
    
    var view: UIView
    var subview: UIImageView
    var img: UIImage
    var layoutManager: ButtonLayoutManager
    
    init(ratingMap: EmojiRatingMap, imagePath: String, view: UIView,
        translationX: CGFloat, translationY: CGFloat, scaleFactor: CGFloat, layoutManager: ButtonLayoutManager) {
            self.view = view
            self.layoutManager = layoutManager
            
            self.img = UIImage(contentsOfFile: imagePath)
            var tap: UITapGestureRecognizer! = UITapGestureRecognizer()
            
            self.subview = UIImageView(frame: CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.size.width * scaleFactor, height: view.frame.size.height * scaleFactor)))
            self.subview.image = UIImage(contentsOfFile: imagePath)
            
            
            self.subview.addGestureRecognizer(tap)
            
            self.view.addSubview(self.subview)

            //self.subview.setTranslatesAutoresizingMaskIntoConstraints(false)
            var buttonCenterX = NSLayoutConstraint(item: self.subview,
                attribute: .CenterX, relatedBy: .LessThanOrEqual, toItem: self.view,
                attribute: .CenterX, multiplier: 1.0, constant: translationX)
            var buttonCenterY = NSLayoutConstraint(item: self.subview,
                attribute: .CenterY, relatedBy: .LessThanOrEqual, toItem: self.view,
                attribute: .CenterY, multiplier: 1.0, constant: translationY)
            
            self.view.addConstraints([buttonCenterX, buttonCenterY])
            
            super.init()
            
            tap.addTarget(self, action: "tapped:")
            
    }
    
    func randomColor() -> UIColor {
        var red = CGFloat(arc4random_uniform(256)) / 256.0
        var green = CGFloat(arc4random_uniform(256)) / 256.0
        var blue = CGFloat(arc4random_uniform(256)) / 256.0
        var alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    func tapped(sender: UIGestureRecognizer) {
        
    }
    
    
    
    class func generateButton(#title: String) -> UIButton {
        var button = UIButton.buttonWithType(.System) as UIButton
        button.setTitle(title, forState: .Normal)
        
        button.sizeToFit()
        button.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        //button.titleLabel!.font = UIFont(name: "MarkerFelt-Thin", size: 32)
        
        button.backgroundColor = UIColor(red: 255.0, green: 0.0, blue: 0.0, alpha: 0.5)
        
        // button.layer : CALayer (tweak minor UI things)
        button.layer.cornerRadius = 5
        
        
        
        return button
    }
}
