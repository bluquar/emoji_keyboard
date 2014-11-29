//
//  ButtonLayoutManager.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class ButtonLayoutManager: NSObject {
    // Constants
    let marginpx: CGFloat = 10
    let insertionLabelOpacityDecrement: CGFloat = 0.04
    let insertionLabelOpacityTimeDelta: UInt64 = 25 * NSEC_PER_MSEC
    let insertionLabelOpacityStart: CGFloat = 0.6
    
    // Delegates & External objects
    var view: UIView!
    var kbDelegate: KeyboardViewController!
    var settings: SettingsManager
    var options: [[SelectionOption?]]
    
    // UI Components
    var nextKeyboardButton: UIButton!
    var gridView: UIView!
    var cells: [[UIView]]
    var contentCells: [[UIView!]]
    var insertionLabel: UILabel!
    
    init(settings: SettingsManager) {
        self.settings = settings
        self.cells = []
        self.contentCells = []
        self.options = []
        super.init()
    }
    
    func viewDidLoad(view: UIView) {
        self.view = view
        self.setupUI()
    }
    
    func setupUI() {
        self.initializeNextKBbutton()
        // jesus fucking christ please work
        //self.initializeInsertionLabel()
        //self.initializeGrid()
        self.view.layoutSubviews()
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
    
    func addListeners(cell: UIControl, row: Int, col: Int) -> () {
        TouchListener(controller: self, cell: cell, row: row, col: col)
    }
    
    func selected(row: Int, col: Int) -> () {
        self.options[row][col]!.selected()
    }
    
    func initializeGrid() {
        let rows: Int = self.settings.rows
        let cols: Int = self.settings.cols
        
        // create grid view and cell views
        self.gridView = UIView()
        self.view.addSubview(self.gridView)
        
        self.cells = [[UIView]]()
        self.options = [[SelectionOption?]]()
        
        for row in 0..<rows {
            var thisRow = [UIView]()
            var rowOptions = [SelectionOption?]()
            for col in 0..<cols {
                rowOptions.append(nil)
                let cell = UIControl()
                thisRow.append(cell)
                self.gridView.addSubview(cell)
                self.addListeners(cell, row: row, col: col)
            }
            self.cells.append(thisRow)
            self.options.append(rowOptions)
        }
        
        // constrain he grid view in relation to the keyboard view
        var constraints = [
            NSLayoutConstraint(item: self.gridView, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: self.marginpx),
            NSLayoutConstraint(item: self.gridView, attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -self.marginpx),
            NSLayoutConstraint(item: self.gridView, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: self.marginpx),
            NSLayoutConstraint(item: self.gridView, attribute: .Bottom, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute: .Top, multiplier: 1.0, constant: -self.marginpx)
        ]
        
        
        // constrain the cells in relation to each other and the grid view
        
        let canon = self.cells[0][0]
        // aspect ratio
        constraints.append(NSLayoutConstraint(item: canon, attribute: .Height, relatedBy: .LessThanOrEqual,
            toItem: canon, attribute: .Width, multiplier: 0.7, constant: 0.0))
        
        // All same width and height:
        for row in 0..<rows {
            for col in 0..<cols {
                if row != 0 || col != 0 {
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col], attribute: .Width, relatedBy: .Equal, toItem: canon, attribute: .Width, multiplier: 1.0, constant: 0.0))
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col], attribute: .Height, relatedBy: .Equal, toItem: canon, attribute: .Height, multiplier: 1.0, constant: 0.0))
                }
            }
        }
        
        // Rows all locked to the left and right
        for row in 0..<rows {
            constraints.append(NSLayoutConstraint(item: self.cells[row][0], attribute: .Left, relatedBy: .Equal, toItem: self.gridView, attribute: .Left, multiplier: 1.0, constant: 0.0))
            constraints.append(NSLayoutConstraint(item: self.cells[row][self.cells[row].count-1], attribute: .Right, relatedBy: .Equal, toItem: self.gridView, attribute: .Right, multiplier: 1.0, constant: 0.0))
        }
        
        // Cols all locked to the top and bottom
        for col in 0..<cols {
            constraints.append(NSLayoutConstraint(item: self.cells[0][col], attribute: .Top, relatedBy: .Equal, toItem: self.gridView, attribute: .Top, multiplier: 1.0, constant: 0.0))
            constraints.append(NSLayoutConstraint(item: self.cells[self.cells.count-1][col], attribute: .Bottom, relatedBy: .Equal, toItem: self.gridView, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        }
        
        // inter-cell spacing
        for row in 0..<rows {
            for col in 0..<cols {
                if row + 1 < rows {
                    constraints.append(NSLayoutConstraint(item: self.cells[row+1][col], attribute: .Top, relatedBy: .Equal, toItem: self.cells[row][col], attribute: .Bottom, multiplier: 1.0, constant: self.marginpx))
                }
                if col + 1 < cols {
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col+1], attribute: .Left, relatedBy: .Equal, toItem: self.cells[row][col], attribute: .Right, multiplier: 1.0, constant: self.marginpx))
                }
            }
        }
        self.view.addConstraints(constraints)
    }
    
    func optionsPerGrid() -> Int {
        return self.settings.rows * self.settings.cols
    }
    
    func clearAllOptions() -> () {
        for row in 0..<self.settings.rows {
            for col in 0..<self.settings.cols {
                self.options[row][col]?.detach()
            }
        }
    }
    
    func updateButtons(options: [SelectionOption]) -> () {
        let n = options.count
        assert({
            return n == self.optionsPerGrid();
            }(), {
                return "Invalid number of options";
        }())
        
        self.clearAllOptions()
        
        var i: Int = 0
        
        for row in 0..<self.settings.rows {
            for col in 0..<self.settings.cols {
                let cell: UIView = self.cells[row][col]
                self.options[row][col]! = options[i]
                options[i].populateView(cell)
            }
        }
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
    
    func updateViewConstraints() -> () {
        // Todo
    }
}
