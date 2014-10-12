//
//  EmojiSelection.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/11/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelection: NSObject {
    var weights: EmojiRatingMap
    var image: UIImage
    
    init(path: String, associations: [String: Int]) {
        self.weights = EmojiRatingMap()
        self.weights.update(associations)
        self.image = UIImage(named: path)
    }
}
