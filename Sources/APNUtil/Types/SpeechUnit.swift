//
//  SpeechUnit.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/22/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import AVFoundation

public struct SpeechUnit {
    
    var word: String
    var delay: Double!  = 0.0
    var pitch:Float!    = 1.0
    var rate: Float!    = AVSpeechUtteranceDefaultSpeechRate
    var voice: Voice    = .British
    
    private static let defaultPitch = 1.25
    private static let shortPause   = "[0.0:\(defaultPitch):\(AVSpeechUtteranceDefaultSpeechRate)]"
    private static let commaPause   = "[0.1:\(defaultPitch):\(AVSpeechUtteranceDefaultSpeechRate)]"
    private static let periodPause  = "[0.2:\(defaultPitch):\(AVSpeechUtteranceDefaultSpeechRate)]"
    private static let elipsesPause = "[0.3:\(defaultPitch):\(AVSpeechUtteranceDefaultSpeechRate)]"
    
    /// Parses `unparsedStringTokens` return an array of `[Word]` from the parsed tokens.
    /// - important: parsed tokens take the form "[Delay:Pitch:Rate]Word"
    public static func fromFormattedText(_ unparsed: String,
                                         withVoice voice: Voice) -> [SpeechUnit] {
        
        var spunits = [SpeechUnit]()
        var unparsed = " \(unparsed)"
        
        unparsed = unparsed.replacingOccurrences(of: "<<",
                                                 with: "[" )
        
        unparsed = unparsed.replacingOccurrences(of: ">>",
                                                 with: ":\(defaultPitch):0.5]")
        
        unparsed = unparsed.replacingOccurrences(of: "...",
                                                 with: SpeechUnit.elipsesPause)
        
        unparsed = unparsed.replacingOccurrences(of: #"[\!|\?]"#,
                                                 with: SpeechUnit.periodPause,
                                                 options:. regularExpression)
        
        unparsed = unparsed.replacingOccurrences(of: #"[\,|\;]"#,
                                                 with: SpeechUnit.commaPause,
                                                 options:. regularExpression)
        
        let tokens = unparsed.split(separator: "[")
        
        for token in tokens {
            
            let atts = ("\(token) ").replacingOccurrences(of: "]", with: ":").split(separator: ":")
                
            let word    = atts.count > 1 ? atts[3] : atts[0]
            let delay   = atts.count > 1 ? atts[0] : "0"
            let pitch   = atts.count > 1 ? atts[1] : "\(defaultPitch)"
            let rate    = atts.count > 1 ? atts[2] : "0.5"
            
            let spunit = SpeechUnit(word:   String(word),
                                  delay:    Double(delay),
                                  pitch:    Float(pitch),
                                  rate:     Float(rate),
                                  voice:    voice)
            
            spunits.append(spunit)
            
        }
        
        return spunits /*EXIT*/
        
    }
    
}
