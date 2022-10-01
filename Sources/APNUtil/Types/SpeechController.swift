//
//  SpeechController.swift
//  RoriSpell
//
//  Created by Aaron Nance on 2/20/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import UIKit
import AVFoundation

public enum Voice: String, CustomStringConvertible {
    
    case American   = "en-US"
    case Australian = "en-AU"
    case Kiwi       = "en-ZA"
    case Irish      = "en-IE"
    case British    = "en-GB"
    
    public var description: String { return self.rawValue }
    
}

public class SpeechController: NSObject {
    
    // MARK: - Properties
    private var synthesizer = AVSpeechSynthesizer()
    private var completion: VoidHandler?
    
    var isSpeaking: Bool { synthesizer.isSpeaking }
    
    
    // MARK: - Overrides
    public override init() {
        
        super.init()
        
        synthesizer.delegate = self
        
    }
    
    /// Speaks the specified text without applying any modifications to the utterance.
    /// - note: For changing pitch, rate, or adding delays see `sayNuanced()`.
    public func saySimple(_ text: String,
                          withVoiceLanguage voice: Voice = .British,
                          completion: VoidHandler? = nil ) {
        
        #if DEBUG
        print("\(#function)\n\(text)")
        #endif
        
        // Stop already running utterances
        synthesizer.stopSpeaking(at: .immediate)
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: voice.rawValue)
        
        self.completion = completion
        
        synthesizer.speak(utterance)
        
    }
    
    /// [BROKEN] Parses formatted speech text into an array [SpeechUnit] that can each have their own
    /// modified utterance properties.
    ///
    /// - important: sayNuanced is totally unreliable owing to a bug in adjusting pre/post
    /// utterance delays.  This causes the AVSpeechSynthesizer to stop working w/o warning
    /// or reported error.
    ///
    /// - important: see `SpeechUnit.fromFormattedText` to learn how to formatt text for
    /// sayNuanced.
    public func sayNuanced(_ text:String,
                           withVoiceLanguage voice: Voice = .British,
                           completion: VoidHandler? = nil ) {
        
        let spunits = SpeechUnit.fromFormattedText(text, withVoice: voice)
        
        if spunits.count == 1 {
            
            let spunit = spunits[0]
            
            saySimple(spunit.word,
                      withVoiceLanguage: spunit.voice,
                      completion: completion )
            
        } else {
            
            #if DEBUG
            print("\(#function)\n\(text)")
            #endif
            
            processNuanced(spunits, completion: completion)
            
        }
        
    }
    
    private func processNuanced(_ speechUnits: [SpeechUnit],
                                completion: VoidHandler? = nil ) {
        
        // Stop already running utterances
        synthesizer.stopSpeaking(at: .immediate)
        
        var spunits = speechUnits
        let spunit  = spunits.removeFirst()
            
        self.completion = (spunits.count > 0) ? { self.processNuanced(spunits, completion: completion) } : completion
        
        Utils.performUIUpdatesOnMain {
                        
            let utterance = AVSpeechUtterance(string: spunit.word)
            
            utterance.pitchMultiplier   = spunit.pitch
            utterance.rate              = spunit.rate
            
            utterance.preUtteranceDelay = spunit.delay
            utterance.voice = AVSpeechSynthesisVoice(language: spunit.voice.rawValue)
            
            self.synthesizer.speak(utterance)
        
        }
    }
}

// MARK: - AVSpeechSynthesizerDelegate
extension SpeechController: AVSpeechSynthesizerDelegate {

    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                                  didFinish utterance: AVSpeechUtterance) { completion?() }
    
    /** UNCOMMENT FOR TESTING **
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart: AVSpeechUtterance) {
        print("DID_START: \(#function)")
    }
     
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause: AVSpeechUtterance) {
        print("DID_PAUSE: \(#function)")
    }
     
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue: AVSpeechUtterance) {
        print("DID_CONTINUE: \(#function)")
    }
     
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel: AVSpeechUtterance) {
        print("DID_CANCEL: \(#function)")
    }
     
    public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer,
                                    willSpeakRangeOfSpeechString: NSRange,
                                    utterance: AVSpeechUtterance) {
        
        print("WILL_SPEAK: \(#function)")
        // print("\(utterance.speechString)")
        
    }
    ** UNCOMMENT FOR TESTING **/
    
}
