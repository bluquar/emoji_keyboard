//
//  EmojiScore.swift
//  DecisiveEmojiKeyboard
//
//  Created by Chris Barker on 11/25/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

let allEmojis = Array("😁😂😃😄😅😆😉😊😋😌😍😏😒😓😔😖😘😚😜😝😞😠😡😢😣😤😥😨😩😪😫😭😰😱😲😳😵😷😸😹😺😻😼😽😾😿🙀🙅🙆🙇🙈🙉🙊🙋🙌🙍🙎🙏🚀🚃🚄🚅🚇🚉🚌🚏🚑🚒🚓🚕🚗🚙🚚🚢🚤🚥🚧🚨🚩🚪🚫🚬🚭🚲🚶🚹🚺🚻🚼🚽🚾🛀🅰🅱🅾🅿🆎🆑🆒🆓🆔🆕🆖🆗🆘🆙🆚🇩🇪🇬🇧🇨🇳🇯🇵🇰🇷🇫🇷🇪🇸🇮🇹🇺🇸🇷🇺🈁🈂🈚🈯🈲🈳🈴🈵🈶🈷🈸🈹🈺🉐🉑🀄🃏🌀🌁🌂🌃🌄🌅🌆🌇🌈🌉🌊🌋🌌🌏🌑🌓🌔🌕🌙🌛🌟🌠🌰🌱🌴🌵🌷🌸🌹🌺🌻🌼🌽🌾🌿🍀🍁🍂🍃🍄🍅🍆🍇🍈🍉🍊🍌🍍🍎🍏🍑🍒🍓🍔🍕🍖🍗🍘🍙🍚🍛🍜🍝🍞🍟🍠🍡🍢🍣🍤🍥🍦🍧🍨🍩🍪🍫🍬🍭🍮🍯🍰🍱🍲🍳🍴🍵🍶🍷🍸🍹🍺🍻🎀🎁🎂🎃🎄🎅🎆🎇🎈🎉🎊🎋🎌🎍🎎🎏🎐🎑🎒🎓🎠🎡🎢🎣🎤🎥🎦🎧🎨🎩🎪🎫🎬🎭🎮🎯🎰🎱🎲🎳🎴🎵🎶🎷🎸🎹🎺🎻🎼🎽🎾🎿🏀🏁🏂🏃🏄🏆🏈🏊🏠🏡🏢🏣🏥🏦🏧🏨🏩🏪🏫🏬🏭🏮🏯🏰🐌🐍🐎🐑🐒🐔🐗🐘🐙🐚🐛🐜🐝🐞🐟🐠🐡🐢🐣🐤🐥🐦🐧🐨🐩🐫🐬🐭🐮🐯🐰🐱🐲🐳🐴🐵🐶🐷🐸🐹🐺🐻🐼🐽🐾👀👂👃👄👅👆👇👈👉👊👋👌👍👎👏👐👑👒👓👔👕👖👗👘👙👚👛👜👝👞👟👠👡👢👣👤👦👧👨👩👪👫👮👯👰👱👲👳👴👵👶👷👸👹👺👻👼👽👾👿💀💁💂💃💄💅💆💇💈💉💊💋💌💍💎💏💐💑💒💓💔💕💖💗💘💙💚💛💜💝💞💟💠💡💢💣💤💥💦💧💨💩💪💫💬💮💯💰💱💲💳💴💵💸💹💺💻💼💽💾💿📀📁📂📃📄📅📆📇📈📉📊📋📌📍📎📏📐📑📒📓📔📕📖📗📘📙📚📛📜📝📞📟📠📡📢📣📤📥📦📧📨📩📪📫📮📰📱📲📳📴📶📷📹📺📻📼🔃🔊🔋🔌🔍🔎🔏🔐🔑🔒🔓🔔🔖🔗🔘🔙🔚🔛🔜🔝🔞🔟🔠🔡🔢🔣🔤🔥🔦🔧🔨🔩🔪🔫🔮🔯🔰🔱🔲🔳🔴🔵🔶🔷🔸🔹🔺🔻🔼🔽🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚🕛🗻🗼🗽🗾🗿😀😇😈😎😐😑😕😗😙😛😟😦😧😬😮😯😴😶🚁🚂🚆🚈🚊🚍🚎🚐🚔🚖🚘🚛🚜🚝🚞🚟🚠🚡🚣🚦🚮🚯🚰🚱🚳🚴🚵🚷🚸🚿🛁🛂🛃🛄🛅🌍🌎🌐🌒🌖🌗🌘🌚🌜🌝🌞🌲🌳🍋🍐🍼🏇🏉🏤🐀🐁🐂🐃🐄🐅🐆🐇🐈🐉🐊🐋🐏🐐🐓🐕🐖🐪👥👬👭💭💶💷📬📭📯📵🔀🔁🔂🔄🔅🔆🔇🔉🔕🔬🔭🕜🕝🕞🕟🕠🕡🕢🕣🕤🕥🕦🕧")

func randomEmoji() -> String {
    let index: Int = Int(arc4random_uniform(UInt32(allEmojis.count)))
    return String(allEmojis[index])
}

class EmojiScore: NSObject {
    
    var mapping: Dictionary<String, Int>
    var best: String
    
    override init() {
        self.mapping = [:]
        self.best = ""
        super.init()
        self.updateBest()
    }
    
    convenience init(mapping: [String: Int]) {
        self.init()
        self.mapping = mapping
        self.updateBest()
    }
    
    convenience init(emojis: String) {
        var map: [String: Int] = [:]
        let emojiArray = Array(emojis)
        for emojiChar in emojiArray {
            let emoji = String(emojiChar)
            let idx = map.indexForKey(emoji)
            if (idx == nil) {
                map[emoji] = 1
            } else {
                map[emoji] = 1 + map[emoji]!
            }
        }
        self.init(mapping: map)
    }

    func updateBest() -> Void {
        // O(n) update. Use sparingly!
        var maxRating: Int = -1
        var maxEmoji: String = ""
        for (emoji, rating) in self.mapping {
            if (maxRating < rating || maxEmoji == "") {
                maxEmoji = emoji
                maxRating = rating
            }
        }
        if maxRating < 0 {
            maxEmoji = randomEmoji()
        }
        self.best = maxEmoji
    }
    
    func updateBest(challenger: String) -> Void {
        // O(1) update. Only compares the current maximum and the argument.
        let bestScore: Int = self.score(self.best)
        let challengeScore: Int = self.score(challenger)
        if (challengeScore >= bestScore) {
            self.best = challenger
        }
    }
    
    func add(other: EmojiScore) -> Void {
        for (emoji, score) in other.mapping {
            self.alter(emoji, delta: score)
        }
    }
    
    func dot(other: EmojiScore) -> Int {
        var accum: Int = 0
        if (self.mapping.count > other.mapping.count) {
            for (emoji, score) in other.mapping {
                accum += score * self.score(emoji)
            }
        } else {
            for (emoji, score) in self.mapping {
                accum += score * other.score(emoji)
            }
        }
        return accum
    }
    
    func score(emoji: String) -> Int {
        let idx = self.mapping.indexForKey(emoji)
        if (idx == nil) {
            return 0
        } else {
            return self.mapping[emoji]!
        }
    }
    
    func removeBest() -> String {
        self.mapping[self.best] = -1
        self.updateBest()
        return self.best
    }
    
    func alter(emoji: String, delta: Int) {
        // Alters the score for a single emoji
        // Updates .best if necessary
        if delta != 0 {
            var newScore: Int = self.score(emoji) + delta
            if (newScore == 0) {
                self.mapping.removeValueForKey(emoji)
            } else {
                self.mapping[emoji] = newScore
            }
            self.updateBest(emoji)
        }
    }
}
