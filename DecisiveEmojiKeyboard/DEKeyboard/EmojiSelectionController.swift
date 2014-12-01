//
//  EmojiSelectionController.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

// Implements the core logic of the EmojiSelectKB Keyboard
class EmojiSelectionController: NSObject {
    
    var imageOptions: [ImageSelectionOption]
    
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
        self.imageOptions = []
        self.imageOptionsSelected = [:]
        self.imageOptionsRemaining = [:]
        super.init()
    }
    
    func getImagePath(name: String) -> String {
        return name
    }
    
    func parseImageOptions(text: String) -> [ImageSelectionOption] {
        var options: [ImageSelectionOption] = []
        let lines = text.componentsSeparatedByString("\n")
        var i: Int = 0
        while i+2 < lines.count {
            options.append(ImageSelectionOption(controller: self, path: self.getImagePath(lines[i]), score: EmojiScore(emojis: lines[i+1])))
            i += 3
        }
        return options
    }
    
    func loadImageOptions() -> [ImageSelectionOption] {
        let bundle = NSBundle.mainBundle()
        let resources: [AnyObject] = bundle.pathsForResourcesOfType("txt", inDirectory: nil)
        let path: String = resources[0].stringByResolvingSymlinksInPath
        let text: String = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)!
        let options: [ImageSelectionOption] = self.parseImageOptions(text)
        let loader = BackgroundImageLoader(options: options)
        loader.start()
        return options
    }
    
    func viewDidLoad(keyboardVC: KeyboardViewController) -> Void {
        self.keyboardVC = keyboardVC
        self.imageOptions = self.loadImageOptions()
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
        self.numSelections = 0
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
        self.numSelections++
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
                    bestOption = option
                }
            }
            let idx = imageOptionsRemaining.indexForKey(bestOption!)
            self.imageOptionsRemaining.removeAtIndex(idx!)
            return bestOption!
        }
    }
    
}
