//
//  EmojiSelectionController.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

struct SelectionPriority {
    var selection: EmojiSelection
    var priority: Int
}

// Implements the core logic of the EmojiSelectKB Keyboard
class EmojiSelectionController: NSObject, ButtonSource {
    let maxSelections: Int = 3 // How many choices to make before inserting a character
    var numSelections: Int
    
    var currentSelections: [[EmojiSelection]]        // Maps (row, col) -> EmojiSelection
    var selectionPriorities: [EmojiSelection: Int]   // Maps EmojiSelections to a score (higher score = better fit) based on congruence with selections made
    var accumulator: EmojiRatingMap                     // Maps Emojis to a score based on congruence with selections made
    
    var rows: Int = -1
    var cols: Int = -1
    
    var selections: [EmojiSelection] = [
        EmojiSelection(path: "ears.png", associations: ["🐺": 1]),
        EmojiSelection(path: "kitten.png", associations: ["🐱": 3, "😺": 1, "😸": 1, "😻": 1, "😹": 1,
            "😽": 1, "😼": 1, "🙀": 1, "😿": 1, "😾": 1]),
        EmojiSelection(path: "water.png", associations: ["💦": 1, "💧": 1, "🛀": 1, "🌊": 1, "🌏": 1, "🌎": 1, "🌍": 1]),
        EmojiSelection(path: "playfulkitten.png", associations: ["😸":1, "😹":1, "😺":1, "😻":1, "😼":1, "😽":1, "😾":1, "😿":1, "🙀":1]),
        EmojiSelection(path: "demon.png", associations: ["😖": 1, "😝": 1, "😲": 1, "🐟": 1, "😈": 2, "😡": 1, "😦": 1]),
        EmojiSelection(path: "creeper.png", associations: ["🐍": 1, "🎃": 1, "🃏": 1, "🙀": 1, "😖": 1, "💥": 1]),
        EmojiSelection(path: "clock.png", associations: ["🚏":1, "🚥":1, "🌅":1, "🌌":1, "🔜":1, "🕐":1, "🕑":1, "🕒":1, "🕓":1, "🕔":1, "🕕":1, "🕖":1, "🕗":1, "🕘":1, "🕙":1, "🕚":1, "🕛":1, "🌒":1, "🌖":1, "🌗":1, "🌘":1, "🌚":1, "🌜":1, "🌝":1, "🌞":1, "🕜":1, "🕝":1, "🕞":1, "🕟":1, "🕠":1, "🕡":1, "🕢":1, "🕣":1, "🕤":1, "🕥":1, "🕦":1, "🕧":1]),
        EmojiSelection(path: "bluecandle.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "tree.png", associations: ["🌱": 1, "🌴": 2, "🌵":1, "🌷":1, "🌸":1, "🌹":1, "🌺":1, "🌻":1, "🌼":1, "🌽":1, "🌾":1, "🌿":2, "🍀":1, "🍁":1, "🍂":2, "🍃":1,"🎄":3, "🏡":1,"🌲":2, "🌳":2]),
        EmojiSelection(path: "blueheart.png", associations: ["💛":  1, "💙": 3, "💜": 1, "💚":1, "❤️": 1, "💗": 1, "💓": 1, "💕": 1, "💖": 1, "💞":1, "💘":1, "💌":1]),
        EmojiSelection(path: "cry.png", associations: ["😢":  1, "😂": 1, "😭": 1, "😪":1, "😥": 1, "😰": 1, "😫":1, "😖": 1]),
        EmojiSelection(path: "cute.png", associations: ["🐱":  1, "🐭": 1, "🐯": 1, "🐇":1]),
        EmojiSelection(path: "cutelegs.png", associations: ["🐇":  1, "🐱": 1, "😼": 1, "🙀":1]),
        EmojiSelection(path: "fistbumb.png", associations: ["👊":  3, "👍": 2, "✊": 1, "👌":1]),
        EmojiSelection(path: "flower.png", associations: ["💐":  1, "🌸": 1, "🌷": 1, "🌹":1, "🌻": 1, "🌺":1]),
        EmojiSelection(path: "granite.gif", associations: ["▪️":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "heart.png", associations: ["💛":  1, "💙": 1, "💜": 1, "💚":1, "❤️": 2, "💗": 2, "💓": 2, "💕": 1, "💖": 1, "💞":1, "💘":1, "💌":1]),
        EmojiSelection(path: "kittenpresent.gif", associations: ["🐱":  1, "😺": 1, "😸": 1, "🎁":1]),
        EmojiSelection(path: "present.png", associations: ["🎁":  1, "🔆": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "sadface.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "skullxbones.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "surfboard.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "taco.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "troll.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "zebra.png", associations: ["🔅":  1, "🔥": 1, "🌋": 1, "🚨":1]),
        EmojiSelection(path: "mikeg.png", associations: ["🐱": 10]),
        EmojiSelection(path: "sally.png", associations: ["🐠": 1]),
    ]
    
    override init() {
        self.numSelections = 0
        self.accumulator = EmojiRatingMap(sparse: false)
        self.currentSelections = [[]]
        self.selectionPriorities = Dictionary<EmojiSelection, Int>()
        super.init()
        self.resetState()
    }
    
    // Called by ButtonLayoutManager to indicate a change in the grid size
    func setRowsCols(rows: Int, cols: Int) -> Void {
        self.rows = rows
        self.cols = cols
        self.currentSelections = []
        for row in 0...(self.rows-1) {
            var rowArray: [EmojiSelection] = []
            for col in 0...(self.cols-1) {
                rowArray.append(self.selections[0])
            }
            self.currentSelections.append(rowArray)
        }
        self.updateSelections()
    }
    
    // Helper function responsible for finding the unused EmojiSelection with the highest congruence
    // with the selections made so far
    func bestUnusedSelection() -> EmojiSelection {
        var maxScore = -1
        var bestSelection = self.selections[0]
        for (selection: EmojiSelection, score: Int) in self.selectionPriorities {
            if (score > maxScore) {
                maxScore = score
                bestSelection = selection
            }
        }
        self.selectionPriorities.removeValueForKey(bestSelection)
        return bestSelection
    }
    
    // Helper function called at init and after inserting an Emoji
    func resetState() {
        self.accumulator = EmojiRatingMap(sparse: false)
        self.selectionPriorities = Dictionary<EmojiSelection, Int>()
        self.numSelections = 0
        for selection in self.selections {
            self.selectionPriorities[selection] = 0
        }
    }
    
    // Helper function used at state changes to reassign each EmojiSelection
    func updateSelections() {
        if (self.rows < 1 || self.cols < 1) {
            return
        }
        for row in 0...(self.rows-1) {
            for col in 0...(self.cols-1) {
                self.currentSelections[row][col] = self.bestUnusedSelection()
            }
        }
    }
    
    // Helper function that updates self.selectionPrioties (EmojiSelection -> Int) after a state change
    // `weights` is the EmojiRating vector for the tapped-on selection
    // ∆priority[selection] = dotProduct(weights, selection)
    func updatePriorities(weights: EmojiRatingMap) {
        for (selection, score) in self.selectionPriorities {
            self.selectionPriorities[selection] = score + selection.scoreForAggregate(weights)
        }
    }
    
    // ButtonLayoutManager calls this when the EmojiSelection at [row][col] is tapped
    // If the return value is non-nil, the return value will be inserted as text.
    func updateState(row: Int, col: Int) -> String? {
        let selection = self.currentSelections[row][col]
        self.accumulator.add(selection.weights)
        if (++self.numSelections == self.maxSelections) {
            let s = self.accumulator.getBestEmoji()
            self.resetState()
            self.updateSelections()
            return s
        } else {
            self.updatePriorities(selection.weights)
            self.updateSelections()
            return nil
        }
    }
    
    // ButtonLayoutManager calls this for each grid cell after calling .updateState()
    // If the image does not need to change, this method can return nil.
    func getImage(row: Int, col: Int) -> UIImage? {
        return self.currentSelections[row][col].image
    }
}
