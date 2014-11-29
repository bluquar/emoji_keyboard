//
//  EmojiSelectionController.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

func loadImageOptions() -> [ImageSelectionOption] {
    let options: [ImageSelectionOption] = []
    let bundle = NSBundle.mainBundle()
    let path = bundle.pathForResource("associations", ofType: "txt")
    
    // TODO: Initialize a bunch of ImageSelectionOption objects
    
    return options
}

// Implements the core logic of the EmojiSelectKB Keyboard
class EmojiSelectionController: NSObject {
    
    let imageOptions: [ImageSelectionOption] = loadImageOptions()
    
    let maxSelections: Int = 3 // How many choices to make before inserting a character
    var numSelections: Int
    
    var imageOptionsSelected: [ImageSelectionOption: Bool]
    var imageOptionsRemaining: [ImageSelectionOption: Bool]
    var accumulator: EmojiScore
    var buttonManager: ButtonLayoutManager
    var keyboardVC: KeyboardViewController!
    
    init(buttonManager: ButtonLayoutManager) {
        self.numSelections = 0
        self.buttonManager = buttonManager
        self.accumulator = EmojiScore()
        self.imageOptionsSelected = [:]
        self.imageOptionsRemaining = [:]
        super.init()
    }

    func viewDidLoad(keyboardVC: KeyboardViewController) -> Void {
        self.keyboardVC = keyboardVC
        self.resetState()
    }
    
    func allOptions() -> [ImageSelectionOption: Bool] {
        var options: [ImageSelectionOption: Bool] = [:]
        for option: ImageSelectionOption in self.imageOptions {
            options[option] = true
        }
        return options
    }
    
    func resetState() {
        self.accumulator = EmojiScore()
        self.imageOptionsSelected = [:]
        self.imageOptionsRemaining = self.allOptions()
        self.refreshButtons()
    }
    
    func refreshButtons() -> () {
        self.buttonManager.updateButtons(self.getOptions(self.buttonManager.optionsPerGrid()))
    }
    
    func getOptions(count: Int) -> [SelectionOption] {
        var options: [SelectionOption] = []
        for _ in 0..<count {
            options.append(self.takeBest())
        }
        return options
    }
    
    func readyForEmojiOptions() -> Bool {
        if self.imageOptionsRemaining.count == 0 {
            return true
        }
        else if self.numSelections >= self.maxSelections {
            return true
        }
        return false
    }
    
    func finalSelect(selection: EmojiSelectionOption) -> () {
        self.keyboardVC.insertText(selection.emoji)
        self.resetState()
    }
    
    func incrementalSelect(selection: ImageSelectionOption) -> Void {
        self.accumulator.add(selection.score)
        self.imageOptionsSelected[selection] = true
        self.refreshButtons()
    }
    
    func takeBest() -> SelectionOption {
        if self.readyForEmojiOptions() {
            return EmojiSelectionOption(controller: self, emoji: self.accumulator.removeBest())
        } else {
            var bestOption: ImageSelectionOption? = nil
            var bestRating: Int = -1
            for (option, _) in self.imageOptionsRemaining {
                let rating: Int = option.score.dot(self.accumulator)
                if bestOption == nil || bestRating <= rating {
                    bestRating = rating
                    bestOption! = option
                }
            }
            let idx = imageOptionsRemaining.indexForKey(bestOption!)
            self.imageOptionsRemaining.removeAtIndex(idx!)
            return bestOption!
        }
    }
    
}
