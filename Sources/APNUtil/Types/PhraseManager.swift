//
//  PhraseManager.swift
//  RoriSpell
//
//  Created by Aaron Nance on 2/24/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public enum PhraseContext {
    
    case wrongAnswer
    case rightAnswer
    case introduction
    case conclusionSad
    case conclusionHappy
    case currentPhrase
    case nextPhrase
    case debug
    
}

public class PhraseManager {
    
    private let speechController = SpeechController()
    private let delegate: PhraseManagerDelegate
    
    private var phrasesRights:  ArrayCycler<String>
    private var phrasesWrongs:  ArrayCycler<String>
    private var phrasesNext:    ArrayCycler<String>
    
    public init(delegate: PhraseManagerDelegate) {
        
        self.delegate = delegate
        
        let rights  = delegate.phrasesRights
        let wrongs  = delegate.phrasesWrongs
        let nexts   = delegate.phrasesNexts
        
        phrasesRights   = ArrayCycler<String>(rights,
                                              cycleType: .shuffle)
        
        phrasesWrongs   = ArrayCycler<String>(wrongs,
                                              cycleType: .shuffle)
        
        phrasesNext     = ArrayCycler<String>(nexts,
                                              cycleType: .shuffle)
        
    }
    
    public func speakTo(context: PhraseContext,
                        withVoice voice: Voice?     = nil,
                        introSpeech: String?        = nil,
                        outroSpeech: String?        = nil,
                        completion: VoidHandler?    = nil) {
        
        var saying: String!
        
        switch context {
            
            case .wrongAnswer:
                saying = phrasesWrongs.next
                
            case .rightAnswer:
                saying = phrasesRights.next
                
            case .introduction:
                saying = delegate.phrasesIntro.randomElement()
                
            case .conclusionHappy:
                saying = delegate.phrasesConclusionHappy.randomElement()

            case .conclusionSad:
                saying = delegate.phrasesConclusionSad.randomElement()
            
            case .currentPhrase:
                saying = delegate.currentPhraseToSpeak
                
            case .nextPhrase:
                saying = phrasesNext.next
                
            case .debug:
                saying = ""
                
        }
        
        // Add intro/outro speech
        saying = "\(introSpeech ?? "")\(saying ?? "")\(outroSpeech ?? "")"
        
        /// Expand `ActionTokens`
        saying = ActionTokenParser.parse(saying)
        
        // NOTE: sayNuanced could be used to add custom pauses in speech
        //       BUT b/c of Apple bug in AVSpeechSynthesizer it is unreliable
        //       at present.
        speechController.saySimple(saying!,
                                   completion: completion)
        
    }
    
}

// MARK: - PhraseManagerDelegate
public protocol PhraseManagerDelegate {
    
    var currentPhraseToSpeak: String? { get }
    var attempts: Int? { get }
    var phrasesRights: [String] { get }
    var phrasesWrongs: [String] { get }
    var phrasesNexts: [String] { get }
    var phrasesIntro: [String] { get }
    var phrasesConclusionHappy: [String] { get }
    var phrasesConclusionSad: [String] { get }
    
}
