//
//  TokenParser.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/25/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

/// Text containing formatted`ActionToken` text to be acted upon by an `Action`
public typealias ActionFormattedText = String

/// Closure taking an `ActionArgument` and returning a String manipulation of that argument. Used to
/// manipulate `ActionFormattedText` `ActionTokens`
public typealias Action = (ActionArgument) -> String

/// `Key` used to referencing an `Action` value in a `ActionDictionary`.
public typealias ActionKey   = String

/// `String` argument to be passed to an `Action`
public typealias ActionArgument = String

/// `Collection` for managing `Actions` values keyed on `ActionKeys`
public typealias ActionDictionary = [ ActionKey : Action ]

/// Class for performing string mainpulation actions on tokens in specially formatted text.
///
/// To use, call  `ActionTokenParser.parse(_:)` passing in
/// `ActionFormattedText` (i.e.  text formatting according to a `ActionTokenFormat`).
///
/// Optionally specify the formatting of the tokens via a custom
/// `ActionTokenFormat` (default formatting should be adequate in most cases).
///
/// Also optionally specify how the tokens are "acted upon" by providing a custom `ActionDictionary`.
///
///
/// Example 1 (defaults):
///
///     let toParse = "Welcome «random:Beatrix,Pickles,Jellybean»!"
///     let parsed = ActionTokenParser.parse(toParse)
///
///     print(parsed)
///
/// - Result:  randomly prints one of three possible sentences:
///     - "Welcome Jellybean!"
///     - "Welcome Beatrix!"
///     - "Welcome Pickles!"
///
/// - Here  there is one `ActionToken`,  "«addRandom:Bea,Pickles,Jellybean»", formatted to match the
/// default `ActionTokenFormat` and consists of everything between the defaul opening and closing
/// delimiters("«" and "»").
///
/// - Between these opening and closing characters the token  is divided into the `ActionKey` and
/// `ActionArgument`.  These two are  separated by the default token delimiter Character ":".
///
/// - The `ActionKey` here refers to the `defaultAction's` "random"
/// key (i.e. `ActionTokenParser.defaultActions["random"]`
/// which contains the "random" `Action` closure; this closure takes an `ActionArgument` (i.e. `String`)
/// and attempts to split it on the "," `Charcter`, randomly returning an `String` `Element` from the
/// resulting `[String]` `Array`.
///
/// Example 2 (custom formatted `ActionToken`):
///
///     let toParse = "Welcome [random>Beatrix,Pickles,Jellybean]!"
///
///     let format = ActionTokenFormat(tokenStart: "[",
///                                    tokenEnd: "]",
///                                    tokenDelimiter: ">" )
///
///     let parsed = ActionTokenParser.parse(toParse,
///                                          format: format)
///
///     print(parsed)
///
/// - Has the  same result as Example 2 but uses custom ActionToken formatting(i.e. `[>]` rather than the
/// default `«:»`).
///
/// Example 3 (custom actions):
///
///     let toParse = "Ho«repeat2x:Ho», Merry Christmas!"
///     let actions: ActionDictionary = [ "repeat2x" : { " \($0) \($0)" } ]
///
///     print(ActionTokenParser.parse(toParse,
///                                   actions: actions) )
///
/// - Returns "Ho Ho Ho, Merry Christmas!"
///
public struct ActionTokenParser {
    
    enum ParseMode {
        
        /// Parser is currently gatherin `ActionKey`
        case gettingKeyValue
        
        /// Parser is currently gathering `ActionArgument`
        case gettingTokenArgument
        
        /// Parser is curring gathering non-token text.
        case gettingNonTokenText
        
    }
    
    /// Performs string manipulation on tokenized formatted text.
    ///
    /// - Parameters:
    ///     - text: string containing 0 or more `ActionToken`s to act upon.
    ///     - tokenFormat: struct  describing the formatting of tokens to parse for. The default should
    ///     should be used
    ///     unless the text you are parsing requires use of one of the three default delimiter
    ///     `Characters` (see `ActionTokenFormat`)
    ///     - actions: a `Dictionary` of  `[ActionKey : (ActionArgument) -> String]`
    ///     used to perform String manipulations on tokenized text.
    /// - returns: string containing tokens replaced replaced with string manipulations performed by
    /// specified actions.
    public static func parse(_ text: ActionFormattedText,
                             format: ActionTokenFormat = ActionTokenFormat.default,
                             actions: [ ActionKey : (String) -> String ] = [:] ) -> String {
        
        var parsed = ""
        var parseMode: ParseMode = .gettingNonTokenText

        let actions = actions.count == 0 ? defaultActions : actions
        var token = ActionToken()
        
        for c in text {
        
            switch c {
                
                case format.tokenStart :
                    
                    token = ActionToken()
                    
                    parseMode = .gettingKeyValue
                    
                case format.tokenEnd :
                    
                    parseMode = .gettingNonTokenText
                
                    let action = actions[token.key]
                    parsed += action?(token.arg) ?? ""
                    
                default:
                    
                    switch parseMode {
                        
                        case .gettingKeyValue:
                            
                            if c == format.tokenDelimiter {
                                
                                parseMode = .gettingTokenArgument;
                                
                                break /*BREAK*/
                                
                            }
                            
                            token.key.append(c)
                            
                        case .gettingTokenArgument: token.arg.append(c)
                                                    
                        case .gettingNonTokenText : parsed.append(c)
                            
                }
                
            }
            
        }
        
        return parsed /*EXIT*/
        
    }
}

// MARK: - Actions
extension ActionTokenParser {
    
    /// `Collection` of useful/common/example `Actions` to be available by default
    /// to `ActionTokenParser.parse(_:)`
    private static let defaultActions: [ ActionKey : Action ] = [
    
        "happy" : { $0 + "=)" },
        "random" : { String($0.split(separator: ",").randomElement!) }
    
    ]
    
}

// MARK: - ActionToken
/// Struct for specifiying the `key` and `argument` value to be used for taking action on an `ActionToken`.
public struct ActionToken {
    
    /// A `Dictionary` `key` referencing the `Action` to be called upon `arg`.
    var key: ActionKey
    
    /// Specifies the argument to be passed to the `Action` referred to by `key`.
    var arg: ActionArgument
    
    init() {
        
        key = ""
        arg = ""
        
    }
    
}

// MARK: - ActionTokenFormat
/// Struct defining a  format specification for tokens  in `ActionFormattedText`.
/// Used to tell the ActionTokenParser.parse() what constitutes an `ActionToken` versus plain text.
public struct ActionTokenFormat {
    
    /// Default format `ActionFormattedText` `ActionToken` parsing  delimiters.
    public static let `default` = ActionTokenFormat(tokenStart: "«",
                                                    tokenEnd: "»",
                                                    tokenDelimiter: ":")
    
    /// Character used to delineate the start of an `ActionToken`
    let tokenStart: Character
    
    /// Character used to delineate the end of an`ActionToken`
    let tokenEnd: Character
    
    /// Characer used to delineate the boundary between and `ActionToken's` `ActionKey` and
    /// the `ActionArgument`
    let tokenDelimiter: Character
    
    public init(tokenStart: Character,
                tokenEnd: Character,
                tokenDelimiter: Character) {
        
        self.tokenStart     = tokenStart
        self.tokenEnd       = tokenEnd
        self.tokenDelimiter = tokenDelimiter
        
    }
    
}
