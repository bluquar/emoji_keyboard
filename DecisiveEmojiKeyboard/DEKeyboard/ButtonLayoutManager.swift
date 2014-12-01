//
//  ButtonLayoutManager.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

struct DEConstantsType {
    var marginpx: CGFloat
    var buttonCornerRadius: CGFloat
    var buttonColorDefault: UIColor
    var buttonColorPressed: UIColor
    var insertionLabelOpacityDecrement: CGFloat
    var insertionLabelOpacityTimeDelta: UInt64
    var insertionLabelOpacityStart: CGFloat
    var loadingTimeDelta: UInt64
}
let DE = DEConstantsType(
    marginpx: 10,
    buttonCornerRadius: 10,
    buttonColorDefault: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0),
    buttonColorPressed: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4),
    insertionLabelOpacityDecrement: 0.04,
    insertionLabelOpacityTimeDelta: 25 * NSEC_PER_MSEC,
    insertionLabelOpacityStart: 0.6,
    loadingTimeDelta: 5 * NSEC_PER_MSEC
)

class ButtonLayoutManager: NSObject {
    // Delegates & External objects
    var view: UIView!
    var kbDelegate: KeyboardViewController!
    var settings: SettingsManager
    var options: [[SelectionOption?]]
    
    // UI Components
    var nextKeyboardButton: UIButton!
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
        self.initializeInsertionLabel()
        self.initializeGrid()
        self.initializeNextKBbutton()
        self.applyUIConstraints()
    }
    
    func applyUIConstraints() -> () {
        let rows = self.settings.rows
        let cols = self.settings.cols
    
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.insertionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: DE.marginpx),
            NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: -DE.marginpx),
            // button aspect ratio
            NSLayoutConstraint(item: self.cells[0][0], attribute: .Height, relatedBy: .LessThanOrEqual,
                toItem: self.cells[0][0], attribute: .Width, multiplier: 0.7, constant: 0.0)
        ]
        // cells same size as each other
        for row in 0..<rows {
            for col in 0..<cols {
                if row != 0 || col != 0 {
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col], attribute: .Width, relatedBy: .Equal, toItem: self.cells[0][0], attribute: .Width, multiplier: 1.0, constant: 0.0))
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col], attribute: .Height, relatedBy: .Equal, toItem: self.cells[0][0], attribute: .Height, multiplier: 1.0, constant: 0.0))
                }
            }
        }
        // Rows all locked to the left and right
        for row in 0..<rows {
            constraints.append(NSLayoutConstraint(item: self.cells[row][0], attribute: .Left, relatedBy: .Equal, toItem: self.view, attribute: .Left, multiplier: 1.0, constant: DE.marginpx))
            constraints.append(NSLayoutConstraint(item: self.cells[row][self.cells[row].count-1], attribute: .Right, relatedBy: .Equal, toItem: self.view, attribute: .Right, multiplier: 1.0, constant: -DE.marginpx))
        }
        
        // Cols all locked to the top and bottom
        for col in 0..<cols {
            constraints.append(NSLayoutConstraint(item: self.cells[0][col], attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1.0, constant: DE.marginpx))
            constraints.append(NSLayoutConstraint(item: self.cells[self.cells.count-1][col], attribute: .Bottom, relatedBy: .Equal, toItem: self.nextKeyboardButton, attribute: .Top, multiplier: 1.0, constant: -DE.marginpx))
        }
        
        // inter-cell spacing
        for row in 0..<rows {
            for col in 0..<cols {
                cells[row][col].setTranslatesAutoresizingMaskIntoConstraints(false)
                if row + 1 < rows {
                    constraints.append(NSLayoutConstraint(item: self.cells[row+1][col], attribute: .Top, relatedBy: .Equal, toItem: self.cells[row][col], attribute: .Bottom, multiplier: 1.0, constant: DE.marginpx))
                }
                if col + 1 < cols {
                    constraints.append(NSLayoutConstraint(item: self.cells[row][col+1], attribute: .Left, relatedBy: .Equal, toItem: self.cells[row][col], attribute: .Right, multiplier: 1.0, constant: DE.marginpx))
                }
            }
        }
        constraints.append(NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: self.insertionLabel!, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: self.insertionLabel!, attribute: .Width, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Width, multiplier: 1.0, constant: 0.0))
        constraints.append(NSLayoutConstraint(item: self.insertionLabel!, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: 0.0))
        
        constraints.append(NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: self.cells[0][0], attribute: .Height, multiplier: 0.5, constant: 0.0))
        
        self.view.addConstraints(constraints)
        
        self.view.layoutSubviews()
    }
    
    func initializeNextKBbutton() {
        self.nextKeyboardButton = UIButton.buttonWithType(.System) as UIButton
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        
        self.nextKeyboardButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.nextKeyboardButton.addTarget(self.kbDelegate, action: "advanceToNextInputMode", forControlEvents: .TouchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
    }
    
    func selected(row: Int, col: Int) -> () {
        self.options[row][col]!.selected()
    }
    
    func initializeGrid() {
        let rows: Int = self.settings.rows
        let cols: Int = self.settings.cols

        // create grid view and cell views
        
        self.cells = []
        self.options = []
        
        for row in 0..<rows {
            var thisRow = [UIView]()
            var rowOptions = [SelectionOption?]()
            for col in 0..<cols {
                rowOptions.append(nil)
                let cell = UIControl()
                cell.layer.cornerRadius = 10
                cell.layer.borderWidth = 2
                cell.layer.borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.1).CGColor
                cell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
                thisRow.append(cell)
                self.view.addSubview(cell)
            }
            self.cells.append(thisRow)
            self.options.append(rowOptions)
        }
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
                self.options[row][col] = options[i]
                options[i].populateView(cell)
                i++
            }
        }
        self.applyUIConstraints()
    }
    
    func initializeInsertionLabel() {
        self.insertionLabel = UILabel()
        self.insertionLabel?.text = "∆"
        self.insertionLabel?.alpha = 0.0
        self.insertionLabel?.font = UIFont.systemFontOfSize(200)
        self.insertionLabel?.adjustsFontSizeToFitWidth = true
        self.view.addSubview(self.insertionLabel!)
        self.insertionLabel!.setTranslatesAutoresizingMaskIntoConstraints(false)
    }
    
    func diminishInsertionLabel() {
        if (self.insertionLabel!.alpha < DE.insertionLabelOpacityDecrement) {
            self.insertionLabel!.alpha = 0.0
        } else {
            self.insertionLabel!.alpha -= DE.insertionLabelOpacityDecrement
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(DE.insertionLabelOpacityTimeDelta))
            dispatch_after(time, dispatch_get_main_queue(), {
                self.diminishInsertionLabel()
            })
        }
    }
    
    func showInsertionLabel(c: String) {
        self.insertionLabel!.text = c
        self.insertionLabel!.alpha = DE.insertionLabelOpacityStart + DE.insertionLabelOpacityDecrement
        self.diminishInsertionLabel()
    }
    
    func updateViewConstraints() -> () {
        self.applyUIConstraints()
    }
}
