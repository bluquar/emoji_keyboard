//
//  ButtonLayoutManager.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/2/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

protocol ButtonSource {
    func getOptions(count: Int) -> [SelectionOption]
}

protocol EmojiDecisionMaker {
    func buttonPressed(row: Int, col: Int) -> String?
}

protocol EmojiInserter {
    func insertEmoji(emoji: String) -> Void
}

class ButtonLayoutManager: NSObject {
    // Constants
    let rows: Int = 2
    let cols: Int = 3
    let marginpx: CGFloat = 10
    let insertionLabelOpacityDecrement: CGFloat = 0.04
    let insertionLabelOpacityTimeDelta: UInt64 = 25 * NSEC_PER_MSEC
    let insertionLabelOpacityStart: CGFloat = 0.6
    
    // Delegates & External objects
    var buttonSource: ButtonSource
    var kbDelegate: KeyboardViewController
    var view: UIView
    var proxy: UITextDocumentProxy
    
    // UI Components
    var nextKeyboardButton: UIButton!
    var grid: [[KBButton]]
    var insertionLabel: UILabel!
    
    init(view: UIView, proxy: UITextDocumentProxy, buttonSource: EmojiSelectionController,
        kbdelegate: KeyboardViewController) {
            self.buttonSource = buttonSource
            self.buttonSource.setRowsCols(rows, cols: cols)
            self.proxy = proxy
            self.view = view
            self.grid = []
            self.kbDelegate = kbdelegate
            super.init()
    }
    
    func initializeButtons() {
        self.initializeNextKBbutton()
        self.initializeInsertionLabel()
        self.initializeGrid()
    }
    
    func initializeNextKBbutton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self.kbDelegate, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        let constraints = [
            NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: self.marginpx),
            NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -self.marginpx)
        ]
        self.view.addConstraints(constraints)
    }
    
    func clearGrid() {
        // TODO: Remove existing KBButton items from self.view
        // (unnecessary for now since we use a static, predefined grid size)
        self.grid = []
    }
    
    func getInterbuttonConstraints(button: KBButton, row: Int, col: Int) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        let container: UIView = button.container
        container.setTranslatesAutoresizingMaskIntoConstraints(false)
        /* Width & Height constraints */
        if (row != 0 || col != 0) {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Width, relatedBy: .Equal, toItem: self.grid[0][0].container, attribute: .Width, multiplier: 1.0, constant: 0.0))
            constraints.append(NSLayoutConstraint(item: container, attribute: .Height, relatedBy: .Equal, toItem: self.grid[0][0].container, attribute: .Height, multiplier: 1.0, constant: 0.0))
        }
        // Y constraints
        if (row == 0) {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: self.marginpx))
        } else {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Top, relatedBy: .Equal, toItem: self.grid[row-1][col].container, attribute: .Bottom, multiplier: 1.0, constant: self.marginpx))
        }
        if (row + 1 == self.rows) {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Bottom, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute: .Top, multiplier: 1.0, constant: -self.marginpx))
        }
        // X constraints
        if (col == 0) {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: self.marginpx))
        } else {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Left, relatedBy: .Equal, toItem: self.grid[row][col-1].container, attribute: .Right, multiplier: 1.0, constant: self.marginpx))
        }
        if (col + 1 == self.cols) {
            constraints.append(NSLayoutConstraint(item: container, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -self.marginpx))
        }
        
        return constraints
    }
    
    func initializeGrid() {
        if (self.rows == 0 || self.cols == 0) {
            return
        }
        self.clearGrid()
        self.grid = []
        for row in 0...(self.rows-1) {
            var row_array: [KBButton] = []
            for col in 0...(self.cols-1) {
                let next_button = KBButton(view: self.view, layoutManager: self)
                next_button.addToLayout(row, col: col)
                row_array.append(next_button)
            }
            self.grid.append(row_array)
        }
        
        var constraints: [NSLayoutConstraint] = []
        for row in 0...rows-1 {
            for col in 0...cols-1 {
                let kbb = self.grid[row][col]
                let theseConstraints = self.getInterbuttonConstraints(kbb, row: row, col: col)
                for constraint in theseConstraints {
                    constraints.append(constraint)
                }
            }
        }
        self.view.addConstraints(constraints)
        
        self.view.layoutSubviews()
        self.updateButtons()
    }
    
    func initializeInsertionLabel() {
        self.insertionLabel = UILabel()
        self.insertionLabel?.text = "∆"
        self.insertionLabel?.alpha = 0.0
        self.insertionLabel?.font = UIFont.systemFontOfSize(175)
        self.view.addSubview(self.insertionLabel!)
        self.insertionLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
        let constraints = [
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.insertionLabel!, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0)
        ]
        self.view.addConstraints(constraints)
    }
    
    func diminishInsertionLabel() {
        if (self.insertionLabel!.alpha < self.insertionLabelOpacityDecrement) {
            self.insertionLabel!.alpha = 0.0
        } else {
            self.insertionLabel!.alpha -= self.insertionLabelOpacityDecrement
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.insertionLabelOpacityTimeDelta))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.diminishInsertionLabel()
            })
        }
    }
    
    func showInsertionLabel(c: String) {
        self.insertionLabel!.text = c
        self.insertionLabel!.alpha = self.insertionLabelOpacityStart + self.insertionLabelOpacityDecrement
        self.diminishInsertionLabel()
    }
    
    func tapped(row: Int, col: Int) {
        let char = self.buttonSource.updateState(row, col: col)
        if (char != nil) {
            self.showInsertionLabel(char!)
            self.proxy.insertText(char!)
        }
        self.updateButtons()
    }
    
    func updateButtons() {
        for row in 0...(self.rows-1) {
            for col in 0...(self.cols-1) {
                let newImage: UIImage? = self.buttonSource.getImage(row, col: col)
                if (newImage != nil) {
                    self.grid[row][col].image.image = newImage!
                }
            }
        }
    }
}
