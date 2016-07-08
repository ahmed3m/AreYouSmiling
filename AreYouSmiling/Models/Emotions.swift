//
//  Emotions.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/7/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON

class Emotions {
    
    var scoresDictionary: [String: Double] = [:]
    
    init(json: JSON) {
        scoresDictionary["sadness"] = json[0]["scores"]["sadness"].doubleValue
        scoresDictionary["anger"] = json[0]["scores"]["anger"].doubleValue
        scoresDictionary["happiness"] = json[0]["scores"]["happiness"].doubleValue
        scoresDictionary["fear"] = json[0]["scores"]["fear"].doubleValue
        scoresDictionary["neutral"] = json[0]["scores"]["neutral"].doubleValue
        scoresDictionary["contempt"] = json[0]["scores"]["contempt"].doubleValue
        scoresDictionary["disgust"] = json[0]["scores"]["disgust"].doubleValue
        scoresDictionary["surprise"] = json[0]["scores"]["surprise"].doubleValue
    }
    
    func getBestEmotion() -> String {
        var bestEmotion: String = ""
        var bestScore: Double = -1.0
        for (emotion, score) in scoresDictionary {
            if score > bestScore {
                bestEmotion = emotion
                bestScore = score
            }
        }
        return bestEmotion
    }
    
    func getRightEmoji(emotion: String) -> Emoji {
        switch emotion {
            case "sadness": return .sadness
            case "anger": return .anger
            case "happiness": return .happiness
            case "fear": return .fear
            case "neutral": return .neutral
            case "contempt": return .contempt
            case "disgust": return .disgust
            default: return .surprise // only case left which is surprise
        }
    }
}