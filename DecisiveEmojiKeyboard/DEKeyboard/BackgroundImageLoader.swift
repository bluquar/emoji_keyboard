//
//  BackgroundImageLoader.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/30/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class BackgroundImageLoader: NSObject {
    
    var optionsRemaining: [ImageSelectionOption: Bool]
    
    init(options: [ImageSelectionOption]) {
        self.optionsRemaining = [:]
        for option in options {
            self.optionsRemaining[option] = true
        }
    }
    
    func getOptionToLoad() -> ImageSelectionOption? {
        var option: ImageSelectionOption? = nil
        // Look for options that are displaying right now
        for (candidate, _) in self.optionsRemaining {
            if candidate.image == nil && candidate.isDisplaying {
                option = candidate
                break
            }
        }
        if option == nil {
            for (candidate, _) in self.optionsRemaining {
                if candidate.image == nil {
                    option = candidate
                    break
                }
            }
        }
        return option
    }
    
    func load() -> () {
        let queue = dispatch_get_main_queue()
        var toLoad = self.getOptionToLoad()
        if toLoad != nil {
            toLoad!.async_load()
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(DE.loadingTimeDelta))
            dispatch_after(time, queue, {
                self.load()
            })
        }
    }
    
    func start() -> () {
        self.load()
        
    }
}
