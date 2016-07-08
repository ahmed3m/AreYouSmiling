//
//  Emotions.swift
//  AreYouSmiling
//
//  Created by Ahmed Abdelrahman on 7/7/16.
//  Copyright © 2016 Ahmed Abdelrahman. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Emotions {
    let sadness: Double
    let anger: Double
    let happiness: Double
    let fear: Double
    let neutral: Double
    let contempt: Double
    let disgust: Double
    let surprise: Double
    
    init(json: JSON) {
        sadness = json[0]["scores"]["sadness"].doubleValue
        anger = json[0]["scores"]["anger"].doubleValue
        happiness = json[0]["scores"]["happiness"].doubleValue
        fear = json[0]["scores"]["fear"].doubleValue
        neutral = json[0]["scores"]["neutral"].doubleValue
        contempt = json[0]["scores"]["contempt"].doubleValue
        disgust = json[0]["scores"]["disgust"].doubleValue
        surprise = json[0]["scores"]["surprise"].doubleValue
    }
    /*
    func findCorrespondingEmoji() -> Emoji {
        
    }
    
    func
     */
}