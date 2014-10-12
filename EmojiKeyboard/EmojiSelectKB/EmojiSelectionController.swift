//
//  EmojiSelectionController.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/5/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

struct SelectionPriority {
    var selection: EmojiSelection
    var priority: Int
}

class EmojiSelectionController: NSObject, ButtonSource {
    let maxSelections: Int = 3
    var numSelections: Int
    var aggregateMapping: EmojiRatingMap            // Maps Emoji -> Points
    var currentSelections: [Int: EmojiSelection]    // Maps [0, 1, 2, 3] -> EmojiSelection (Quadrants)
    var selectionPriorities: [EmojiSelection: Int]    // Maps EmojiSelection to a score
    
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
        EmojiSelection(path: "tree.png", associations: ["🌱": 1, "🌴": 2, "🌵":1, "🌷":1, "🌸":1, "🌹":1, "🌺":1, "🌻":1, "🌼":1, "🌽":1, "🌾":1, "🌿":2, "🍀":1, "🍁":1, "🍂":2, "🍃":1,"🎄":3, "🏡":1,"🌲":2, "🌳":2])
    ]
    
    override init() {
        self.numSelections = 0
        self.aggregateMapping = EmojiRatingMap(sparse: false)
        self.currentSelections = Dictionary<Int, EmojiSelection>()
        self.selectionPriorities = Dictionary<EmojiSelection, Int>()
        super.init()
        self.resetState()
    }
    
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
    
    func resetState() {
        self.aggregateMapping = EmojiRatingMap(sparse: false)
        self.selectionPriorities = Dictionary<EmojiSelection, Int>()
        self.numSelections = 0
        for selection in self.selections {
            self.selectionPriorities[selection] = 0
        }
        self.updateSelections()
    }
    
    func updateButtons(layoutManager: ButtonLayoutManager) {
        for i in (0...3) {
            let selection = self.currentSelections[i]!
            layoutManager.updateButton(i, image: selection.image)
        }
    }
    
    func updateSelections() {
        for i in (0...3) {
            self.currentSelections[i] = self.bestUnusedSelection()
        }
    }
    
    func updatePriorities(weights: EmojiRatingMap) {
        for (selection, score) in self.selectionPriorities {
            self.selectionPriorities[selection] = score + selection.scoreForAggregate(weights)
        }
    }
    
    func updateState(id: Int) -> String? {
        let selection = self.currentSelections[id]!
        self.aggregateMapping.add(selection.weights)
        if (++self.numSelections == self.maxSelections) {
            let s = self.aggregateMapping.getBestEmoji()
            self.resetState()
            return s
        } else {
            self.updatePriorities(selection.weights)
            self.updateSelections()
            return nil
        }
    }
    
}
