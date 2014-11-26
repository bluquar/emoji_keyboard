//
//  EmojiSelection.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/11/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelection: NSObject {
    let loadTimeDelay: UInt64 = 25 * NSEC_PER_MSEC
    
    var weights: EmojiRatingMap
    var image: UIImage
    
    init(path: String, associations: [String: Int]) {
        self.weights = EmojiRatingMap(mapping: associations)
        self.image = UIImage(named: path)!
    }
    
    func update(mapping: EmojiRatingMap) {
        for (emoji, rating) in self.weights.mapping {
            mapping.inc(emoji, amt: rating)
        }
    }
    
    func scoreForAggregate(agg: EmojiRatingMap) -> Int {
        var score = 0
        for (emoji, rating) in self.weights.mapping {
            score += rating * agg.get(emoji)
        }
        return score
    }
}
