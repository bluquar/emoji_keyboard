//
//  EmojiRatingMap.swift
//  EmojiKeyboard
//
//  Created by Chris Barker on 10/5/14.
//  Copyright (c) 2014 Chris Barker. All rights reserved.
//

import UIKit

class EmojiRatingMap: NSObject {
    
    var mapping: Dictionary<String, Int>
    
    func getBestEmoji() -> String {
        var maxRating = -1
        var maxEmoji: String = ":("
        for (emoji, rating) in self.mapping {
            if (maxRating < rating) {
                maxEmoji = emoji
                maxRating = rating
            }
        }
        return maxEmoji
    }
    
    func updateRatings(otherRatings: EmojiRatingMap) {
        for (emoji: String, rating: Int) in otherRatings.mapping {
            var currentRating = self.mapping[emoji]
            if (currentRating != nil) {
                var newRating = currentRating! + rating
                self.mapping[emoji] = newRating
            }
        }
    }
    
    convenience init(approvedEmojis: [String]) {
        self.init()
        
        for (emoji: String) in approvedEmojis {
            var currentRating = self.mapping[emoji]
            if (currentRating != nil) {
                var newRating = currentRating! + 1
                self.mapping[emoji] = newRating
            }
        }
    }
    
    func update(mapping: [String: Int]) {
        for (emoji, rating) in mapping {
            var idx = self.mapping.indexForKey(emoji)
            if (idx != nil) {
                self.mapping.updateValue(self.mapping[emoji]! + rating, forKey: emoji)
            }
        }
    }
    
    override init() {
        self.mapping = ["😁": 0,
            "😂": 0,
            "😃": 0,
            "😄": 0,
            "😅": 0,
            "😆": 0,
            "😉": 0,
            "😊": 0,
            "😋": 0,
            "😌": 0,
            "😍": 0,
            "😏": 0,
            "😒": 0,
            "😓": 0,
            "😔": 0,
            "😖": 0,
            "😘": 0,
            "😚": 0,
            "😜": 0,
            "😝": 0,
            "😞": 0,
            "😠": 0,
            "😡": 0,
            "😢": 0,
            "😣": 0,
            "😤": 0,
            "😥": 0,
            "😨": 0,
            "😩": 0,
            "😪": 0,
            "😫": 0,
            "😭": 0,
            "😰": 0,
            "😱": 0,
            "😲": 0,
            "😳": 0,
            "😵": 0,
            "😷": 0,
            "😸": 0,
            "😹": 0,
            "😺": 0,
            "😻": 0,
            "😼": 0,
            "😽": 0,
            "😾": 0,
            "😿": 0,
            "🙀": 0,
            "🙅": 0,
            "🙆": 0,
            "🙇": 0,
            "🙈": 0,
            "🙉": 0,
            "🙊": 0,
            "🙋": 0,
            "🙌": 0,
            "🙍": 0,
            "🙎": 0,
            "🙏": 0,
            "🚀": 0,
            "🚃": 0,
            "🚄": 0,
            "🚅": 0,
            "🚇": 0,
            "🚉": 0,
            "🚌": 0,
            "🚏": 0,
            "🚑": 0,
            "🚒": 0,
            "🚓": 0,
            "🚕": 0,
            "🚗": 0,
            "🚙": 0,
            "🚚": 0,
            "🚢": 0,
            "🚤": 0,
            "🚥": 0,
            "🚧": 0,
            "🚨": 0,
            "🚩": 0,
            "🚪": 0,
            "🚫": 0,
            "🚬": 0,
            "🚭": 0,
            "🚲": 0,
            "🚶": 0,
            "🚹": 0,
            "🚺": 0,
            "🚻": 0,
            "🚼": 0,
            "🚽": 0,
            "🚾": 0,
            "🛀": 0,
            "🅰": 0,
            "🅱": 0,
            "🅾": 0,
            "🅿": 0,
            "🆎": 0,
            "🆑": 0,
            "🆒": 0,
            "🆓": 0,
            "🆔": 0,
            "🆕": 0,
            "🆖": 0,
            "🆗": 0,
            "🆘": 0,
            "🆙": 0,
            "🆚": 0,
            "🇩🇪": 0,
            "🇬🇧": 0,
            "🇨🇳": 0,
            "🇯🇵": 0,
            "🇰🇷": 0,
            "🇫🇷": 0,
            "🇪🇸": 0,
            "🇮🇹": 0,
            "🇺🇸": 0,
            "🇷🇺": 0,
            "🈁": 0,
            "🈂": 0,
            "🈚": 0,
            "🈯": 0,
            "🈲": 0,
            "🈳": 0,
            "🈴": 0,
            "🈵": 0,
            "🈶": 0,
            "🈷": 0,
            "🈸": 0,
            "🈹": 0,
            "🈺": 0,
            "🉐": 0,
            "🉑": 0,
            "🀄": 0,
            "🃏": 0,
            "🌀": 0,
            "🌁": 0,
            "🌂": 0,
            "🌃": 0,
            "🌄": 0,
            "🌅": 0,
            "🌆": 0,
            "🌇": 0,
            "🌈": 0,
            "🌉": 0,
            "🌊": 0,
            "🌋": 0,
            "🌌": 0,
            "🌏": 0,
            "🌑": 0,
            "🌓": 0,
            "🌔": 0,
            "🌕": 0,
            "🌙": 0,
            "🌛": 0,
            "🌟": 0,
            "🌠": 0,
            "🌰": 0,
            "🌱": 0,
            "🌴": 0,
            "🌵": 0,
            "🌷": 0,
            "🌸": 0,
            "🌹": 0,
            "🌺": 0,
            "🌻": 0,
            "🌼": 0,
            "🌽": 0,
            "🌾": 0,
            "🌿": 0,
            "🍀": 0,
            "🍁": 0,
            "🍂": 0,
            "🍃": 0,
            "🍄": 0,
            "🍅": 0,
            "🍆": 0,
            "🍇": 0,
            "🍈": 0,
            "🍉": 0,
            "🍊": 0,
            "🍌": 0,
            "🍍": 0,
            "🍎": 0,
            "🍏": 0,
            "🍑": 0,
            "🍒": 0,
            "🍓": 0,
            "🍔": 0,
            "🍕": 0,
            "🍖": 0,
            "🍗": 0,
            "🍘": 0,
            "🍙": 0,
            "🍚": 0,
            "🍛": 0,
            "🍜": 0,
            "🍝": 0,
            "🍞": 0,
            "🍟": 0,
            "🍠": 0,
            "🍡": 0,
            "🍢": 0,
            "🍣": 0,
            "🍤": 0,
            "🍥": 0,
            "🍦": 0,
            "🍧": 0,
            "🍨": 0,
            "🍩": 0,
            "🍪": 0,
            "🍫": 0,
            "🍬": 0,
            "🍭": 0,
            "🍮": 0,
            "🍯": 0,
            "🍰": 0,
            "🍱": 0,
            "🍲": 0,
            "🍳": 0,
            "🍴": 0,
            "🍵": 0,
            "🍶": 0,
            "🍷": 0,
            "🍸": 0,
            "🍹": 0,
            "🍺": 0,
            "🍻": 0,
            "🎀": 0,
            "🎁": 0,
            "🎂": 0,
            "🎃": 0,
            "🎄": 0,
            "🎅": 0,
            "🎆": 0,
            "🎇": 0,
            "🎈": 0,
            "🎉": 0,
            "🎊": 0,
            "🎋": 0,
            "🎌": 0,
            "🎍": 0,
            "🎎": 0,
            "🎏": 0,
            "🎐": 0,
            "🎑": 0,
            "🎒": 0,
            "🎓": 0,
            "🎠": 0,
            "🎡": 0,
            "🎢": 0,
            "🎣": 0,
            "🎤": 0,
            "🎥": 0,
            "🎦": 0,
            "🎧": 0,
            "🎨": 0,
            "🎩": 0,
            "🎪": 0,
            "🎫": 0,
            "🎬": 0,
            "🎭": 0,
            "🎮": 0,
            "🎯": 0,
            "🎰": 0,
            "🎱": 0,
            "🎲": 0,
            "🎳": 0,
            "🎴": 0,
            "🎵": 0,
            "🎶": 0,
            "🎷": 0,
            "🎸": 0,
            "🎹": 0,
            "🎺": 0,
            "🎻": 0,
            "🎼": 0,
            "🎽": 0,
            "🎾": 0,
            "🎿": 0,
            "🏀": 0,
            "🏁": 0,
            "🏂": 0,
            "🏃": 0,
            "🏄": 0,
            "🏆": 0,
            "🏈": 0,
            "🏊": 0,
            "🏠": 0,
            "🏡": 0,
            "🏢": 0,
            "🏣": 0,
            "🏥": 0,
            "🏦": 0,
            "🏧": 0,
            "🏨": 0,
            "🏩": 0,
            "🏪": 0,
            "🏫": 0,
            "🏬": 0,
            "🏭": 0,
            "🏮": 0,
            "🏯": 0,
            "🏰": 0,
            "🐌": 0,
            "🐍": 0,
            "🐎": 0,
            "🐑": 0,
            "🐒": 0,
            "🐔": 0,
            "🐗": 0,
            "🐘": 0,
            "🐙": 0,
            "🐚": 0,
            "🐛": 0,
            "🐜": 0,
            "🐝": 0,
            "🐞": 0,
            "🐟": 0,
            "🐠": 0,
            "🐡": 0,
            "🐢": 0,
            "🐣": 0,
            "🐤": 0,
            "🐥": 0,
            "🐦": 0,
            "🐧": 0,
            "🐨": 0,
            "🐩": 0,
            "🐫": 0,
            "🐬": 0,
            "🐭": 0,
            "🐮": 0,
            "🐯": 0,
            "🐰": 0,
            "🐱": 0,
            "🐲": 0,
            "🐳": 0,
            "🐴": 0,
            "🐵": 0,
            "🐶": 0,
            "🐷": 0,
            "🐸": 0,
            "🐹": 0,
            "🐺": 0,
            "🐻": 0,
            "🐼": 0,
            "🐽": 0,
            "🐾": 0,
            "👀": 0,
            "👂": 0,
            "👃": 0,
            "👄": 0,
            "👅": 0,
            "👆": 0,
            "👇": 0,
            "👈": 0,
            "👉": 0,
            "👊": 0,
            "👋": 0,
            "👌": 0,
            "👍": 0,
            "👎": 0,
            "👏": 0,
            "👐": 0,
            "👑": 0,
            "👒": 0,
            "👓": 0,
            "👔": 0,
            "👕": 0,
            "👖": 0,
            "👗": 0,
            "👘": 0,
            "👙": 0,
            "👚": 0,
            "👛": 0,
            "👜": 0,
            "👝": 0,
            "👞": 0,
            "👟": 0,
            "👠": 0,
            "👡": 0,
            "👢": 0,
            "👣": 0,
            "👤": 0,
            "👦": 0,
            "👧": 0,
            "👨": 0,
            "👩": 0,
            "👪": 0,
            "👫": 0,
            "👮": 0,
            "👯": 0,
            "👰": 0,
            "👱": 0,
            "👲": 0,
            "👳": 0,
            "👴": 0,
            "👵": 0,
            "👶": 0,
            "👷": 0,
            "👸": 0,
            "👹": 0,
            "👺": 0,
            "👻": 0,
            "👼": 0,
            "👽": 0,
            "👾": 0,
            "👿": 0,
            "💀": 0,
            "💁": 0,
            "💂": 0,
            "💃": 0,
            "💄": 0,
            "💅": 0,
            "💆": 0,
            "💇": 0,
            "💈": 0,
            "💉": 0,
            "💊": 0,
            "💋": 0,
            "💌": 0,
            "💍": 0,
            "💎": 0,
            "💏": 0,
            "💐": 0,
            "💑": 0,
            "💒": 0,
            "💓": 0,
            "💔": 0,
            "💕": 0,
            "💖": 0,
            "💗": 0,
            "💘": 0,
            "💙": 0,
            "💚": 0,
            "💛": 0,
            "💜": 0,
            "💝": 0,
            "💞": 0,
            "💟": 0,
            "💠": 0,
            "💡": 0,
            "💢": 0,
            "💣": 0,
            "💤": 0,
            "💥": 0,
            "💦": 0,
            "💧": 0,
            "💨": 0,
            "💩": 0,
            "💪": 0,
            "💫": 0,
            "💬": 0,
            "💮": 0,
            "💯": 0,
            "💰": 0,
            "💱": 0,
            "💲": 0,
            "💳": 0,
            "💴": 0,
            "💵": 0,
            "💸": 0,
            "💹": 0,
            "💺": 0,
            "💻": 0,
            "💼": 0,
            "💽": 0,
            "💾": 0,
            "💿": 0,
            "📀": 0,
            "📁": 0,
            "📂": 0,
            "📃": 0,
            "📄": 0,
            "📅": 0,
            "📆": 0,
            "📇": 0,
            "📈": 0,
            "📉": 0,
            "📊": 0,
            "📋": 0,
            "📌": 0,
            "📍": 0,
            "📎": 0,
            "📏": 0,
            "📐": 0,
            "📑": 0,
            "📒": 0,
            "📓": 0,
            "📔": 0,
            "📕": 0,
            "📖": 0,
            "📗": 0,
            "📘": 0,
            "📙": 0,
            "📚": 0,
            "📛": 0,
            "📜": 0,
            "📝": 0,
            "📞": 0,
            "📟": 0,
            "📠": 0,
            "📡": 0,
            "📢": 0,
            "📣": 0,
            "📤": 0,
            "📥": 0,
            "📦": 0,
            "📧": 0,
            "📨": 0,
            "📩": 0,
            "📪": 0,
            "📫": 0,
            "📮": 0,
            "📰": 0,
            "📱": 0,
            "📲": 0,
            "📳": 0,
            "📴": 0,
            "📶": 0,
            "📷": 0,
            "📹": 0,
            "📺": 0,
            "📻": 0,
            "📼": 0,
            "🔃": 0,
            "🔊": 0,
            "🔋": 0,
            "🔌": 0,
            "🔍": 0,
            "🔎": 0,
            "🔏": 0,
            "🔐": 0,
            "🔑": 0,
            "🔒": 0,
            "🔓": 0,
            "🔔": 0,
            "🔖": 0,
            "🔗": 0,
            "🔘": 0,
            "🔙": 0,
            "🔚": 0,
            "🔛": 0,
            "🔜": 0,
            "🔝": 0,
            "🔞": 0,
            "🔟": 0,
            "🔠": 0,
            "🔡": 0,
            "🔢": 0,
            "🔣": 0,
            "🔤": 0,
            "🔥": 0,
            "🔦": 0,
            "🔧": 0,
            "🔨": 0,
            "🔩": 0,
            "🔪": 0,
            "🔫": 0,
            "🔮": 0,
            "🔯": 0,
            "🔰": 0,
            "🔱": 0,
            "🔲": 0,
            "🔳": 0,
            "🔴": 0,
            "🔵": 0,
            "🔶": 0,
            "🔷": 0,
            "🔸": 0,
            "🔹": 0,
            "🔺": 0,
            "🔻": 0,
            "🔼": 0,
            "🔽": 0,
            "🕐": 0,
            "🕑": 0,
            "🕒": 0,
            "🕓": 0,
            "🕔": 0,
            "🕕": 0,
            "🕖": 0,
            "🕗": 0,
            "🕘": 0,
            "🕙": 0,
            "🕚": 0,
            "🕛": 0,
            "🗻": 0,
            "🗼": 0,
            "🗽": 0,
            "🗾": 0,
            "🗿": 0,
            "😀": 0,
            "😇": 0,
            "😈": 0,
            "😎": 0,
            "😐": 0,
            "😑": 0,
            "😕": 0,
            "😗": 0,
            "😙": 0,
            "😛": 0,
            "😟": 0,
            "😦": 0,
            "😧": 0,
            "😬": 0,
            "😮": 0,
            "😯": 0,
            "😴": 0,
            "😶": 0,
            "🚁": 0,
            "🚂": 0,
            "🚆": 0,
            "🚈": 0,
            "🚊": 0,
            "🚍": 0,
            "🚎": 0,
            "🚐": 0,
            "🚔": 0,
            "🚖": 0,
            "🚘": 0,
            "🚛": 0,
            "🚜": 0,
            "🚝": 0,
            "🚞": 0,
            "🚟": 0,
            "🚠": 0,
            "🚡": 0,
            "🚣": 0,
            "🚦": 0,
            "🚮": 0,
            "🚯": 0,
            "🚰": 0,
            "🚱": 0,
            "🚳": 0,
            "🚴": 0,
            "🚵": 0,
            "🚷": 0,
            "🚸": 0,
            "🚿": 0,
            "🛁": 0,
            "🛂": 0,
            "🛃": 0,
            "🛄": 0,
            "🛅": 0,
            "🌍": 0,
            "🌎": 0,
            "🌐": 0,
            "🌒": 0,
            "🌖": 0,
            "🌗": 0,
            "🌘": 0,
            "🌚": 0,
            "🌜": 0,
            "🌝": 0,
            "🌞": 0,
            "🌲": 0,
            "🌳": 0,
            "🍋": 0,
            "🍐": 0,
            "🍼": 0,
            "🏇": 0,
            "🏉": 0,
            "🏤": 0,
            "🐀": 0,
            "🐁": 0,
            "🐂": 0,
            "🐃": 0,
            "🐄": 0,
            "🐅": 0,
            "🐆": 0,
            "🐇": 0,
            "🐈": 0,
            "🐉": 0,
            "🐊": 0,
            "🐋": 0,
            "🐏": 0,
            "🐐": 0,
            "🐓": 0,
            "🐕": 0,
            "🐖": 0,
            "🐪": 0,
            "👥": 0,
            "👬": 0,
            "👭": 0,
            "💭": 0,
            "💶": 0,
            "💷": 0,
            "📬": 0,
            "📭": 0,
            "📯": 0,
            "📵": 0,
            "🔀": 0,
            "🔁": 0,
            "🔂": 0,
            "🔄": 0,
            "🔅": 0,
            "🔆": 0,
            "🔇": 0,
            "🔉": 0,
            "🔕": 0,
            "🔬": 0,
            "🔭": 0,
            "🕜": 0,
            "🕝": 0,
            "🕞": 0,
            "🕟": 0,
            "🕠": 0,
            "🕡": 0,
            "🕢": 0,
            "🕣": 0,
            "🕤": 0,
            "🕥": 0,
            "🕦": 0,
            "🕧": 0]
        
        
    }
}
