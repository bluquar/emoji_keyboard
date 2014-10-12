//
//  EmojiSelectionController.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/5/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiSelectionController: NSObject {
    
    let maxSelections: Int = 6
    var numSelections: Int
    var viewDelegate: ButtonLayoutManager!
    var selections: [EmojiSelection]
    var aggregateMapping: EmojiRatingMap
    var currentSelections: [Int: EmojiSelection]
    
    override init() {
        self.numSelections = 0
        self.selections = [
            EmojiSelection(path: "ears.png", associations: ["🐺": 2])
        ]
        self.aggregateMapping = EmojiRatingMap()
        self.currentSelections = Dictionary<Int, EmojiSelection>()
        super.init()
        self.resetState()
    }
    
    func bestUnusedSelection() -> EmojiSelection {
        return self.selections[0]
    }
    
    func resetState() {
        for i in (0...3) {
            self.currentSelections[i] = self.bestUnusedSelection()
        }
        self.aggregateMapping = EmojiRatingMap()
    }
    
    func updateButtons(layoutManager: ButtonLayoutManager) {
        
        for i in (0...3) {
            let selection = self.currentSelections[i]!
            layoutManager.updateButtonWithImage(selection.image, id: i)
        }
 
        //let exbut: UIButton? = layoutManager.quadrants[2]?.button
        //exbut?.setTitle("", forState: .Normal)
        //exbut.button.setImage(UIImage(named: "kittens.jpg"), forState: .Normal)
        //exbut.button.sizeToFit()
        //exbut.displayLayer(exbut.button.imageView?.layer)
    
        //exbut?.setBackgroundImage(UIImage(named: "twloha.png"), forState: .Normal)
        //println(exbut?.imageView?.image?.size)
    }
    
    func updateState(id: Int) {
        let selection = self.currentSelections[id]!
        self.aggregateMapping.updateRatings(selection.weights)
    }
    
}
