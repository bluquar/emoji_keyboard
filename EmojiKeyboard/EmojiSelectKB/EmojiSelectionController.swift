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
    
    override init() {
        self.numSelections = 0
        super.init()
    }
    
    func tapDot(sender: UIButton!) {
        self.viewDelegate?.proxy.insertText(".")
    }
    
    func setInitialButtons(layoutManager: ButtonLayoutManager) {
        layoutManager.updateButton("😝😛😳😁😣😢\n😔😌😒😞😱😠\n😣😢😂😭😎😴\n😪😥😏😑😰😅", rows: 4, id: 0)
        layoutManager.updateButton("🐶🐺🐧🐦🐱🐭\n🐹🐰🐤🐥🐸🐯\n🐨🐻🐣🐔🐷🐽\n🐴🐑🐍🐢🐘🐼", rows: 4, id: 1)
        layoutManager.updateButton("🎍💝🎉🎊🎎🎒\n🎓🎏🎈🎌🎆🎇\n🎐🎑🔮🎥🎃👻\n🎅🎄📷📀🎁🎋", rows: 4, id: 2)
        layoutManager.updateButton("🏠🏡🔴➖🏫🏢\n🏣🏥🕥◾️🏦🏪\n🏩🏨💟♻️💒⛪️\n🏬🏤🈯️📶🌇🌆", rows: 4, id: 3)
    }
    
    func updateButtons(layoutManager: ButtonLayoutManager, id: Int) {
        
    }
    
}
