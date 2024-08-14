//
//  GapFinder.swift
//  APNUtil
//
//  Created by Aaron Nance on 6/26/24.
//

import Foundation

// - MARK: START HERE
// The gap finding mechanism operates on arrays of GapFindable objects.
//
// To take advantage of gap finding:
//   1. Conform your object to GapFindable
//   2. Create an array of those GapFindable objects.
//   3. Call .findGaps or .describeGaps on that array.
//


// - MARK: GapFindable
/// Protocol that enables an object expressible as an `Integer` to access to
/// `GapFinder` functionality via an extension of Array<GapFindable>
///
/// ````
///     //Note: extending Int in this fashion is already done below
///     extension Int: GapFindable { var asInt: Int { self } }
///
///     var widgetIDs: [Int] = [0,1,2,5,10]
///
///     let gaps: [Gap] = widgetIDs.findGaps(stride: 1)
///     let gapDescription = widgetIDs.describeGaps(stride: 1,
///                                                 inRange range: 0...11,
///                                                 compactFormat: Bool = false)
///
///     print(gapDescription)
///
/// ````
///
public protocol GapFindable { var asInt: Int { get } }

// Add gap finding to [Int]
extension Int: GapFindable { public var asInt: Int { self } }


// - MARK: Gap
/// Data structure describing consecutive missing numeric values in what should 
/// be a sequence of consecutive values differing from the previous value by
/// `stride` amount.
///
/// - note: essentially used to describe missing values in arrays of what
/// should be consecutive sequences of Ints.
///
/// e.g. when searched over the range 1..10, striding by 1,
/// the sequence [1,2,3,5,10] would have 2 `Gap`s: [4], and [6...9]
public struct Gap: Equatable, CustomStringConvertible {
    
    /// Standard display text when no gap exists between two non-gap-values..
    public static let noneFound = "[None Found]"
    
    /// The smallest missing value in this `Gap`
    public private(set) var lowerMissingValue: Int
    
    /// The largest missing value in this `Gap`
    public private(set) var upperMissingValue: Int
    
    /// Expected difference between two consecutive values.
    public private(set) var stride: Int
    
    /// Number of values missing between two non-consecutive non-gap-values.
    public var size: Int { ((upperMissingValue - lowerMissingValue) / stride) + 1}
    
    /// Creates a `Gap`
    /// - Parameters:
    ///   - lowerValue: smallest missing value in `Gap`
    ///   - upperValue: largest missing value in `Gap`
    ///   - stride: the expected distance between consecutive `Gap` values.
    public init(_ lowerValue: Int, _ upperValue: Int, stride: Int) {
        
        self.lowerMissingValue = lowerValue
        self.upperMissingValue   = upperValue
        self.stride     = stride
        
    }
    
    public static func ==(lhs: Gap, rhs: Gap) -> Bool {
        
        lhs.lowerMissingValue  == rhs.lowerMissingValue
        &&
        lhs.upperMissingValue    == rhs.upperMissingValue
        &&
        lhs.stride      == rhs.stride
        
    }
    
    public var description: String {
        
        var output = ""
        
        func centerPad(_ subject: CustomStringConvertible) -> String {
            
            "\(subject.description.centerPadded(toLength: GapFinder.paddWidth))\n"
            
        }
        
        if size == 1  {
            
            output += centerPad(lowerMissingValue)
            
        } else {
            
            output += centerPad(lowerMissingValue)
            output += centerPad("⇣")
            output += centerPad(upperMissingValue)
            
        }
        
        return output
        
    }
    
    public var descriptionSimple: String {
        
        var output = ""
        
        func centerPad(_ subject: CustomStringConvertible) -> String {
            
            "[\(subject.description.centerPadded(toLength: GapFinder.paddWidth))]"
            
        }
        
        if size == 1  {
            
            output += centerPad(lowerMissingValue)
            
        } else {
            
            output += centerPad(lowerMissingValue)
            output += "← \(size) →".centerPadded(toLength: GapFinder.paddWidth + 4)
            output += centerPad(upperMissingValue)
            
        }
        
        return output
        
    }
    
}


// - MARK: Array<GapFindable>
// Give [GapFindable] access to GapFinder functionality.
public extension Array where Element : GapFindable {
    
    /// Returns a tupple containing an array of Integers created via the `GapFindable.asInt`
    /// property and provides a default range if none passed as argument.
    private func gapParams(inRange range: ClosedRange<Int>? = nil) -> (data: [Int],
                                                                       range: ClosedRange<Int>) {
        
        assert(count > 0, "Array cannot be empty")
        
        let data = map{ $0.asInt }
        
        let range = range ?? data.first!...data.last!
        
        return (data, range)
        
    }
    
    /// Converts the array to an array of `Int` via the `GapFindable Elements`
    /// `asInt` properties then finds any gaps larger than a single stride between
    /// consecutive `Int` values.
    ///
    /// - returns: Array of [Gap], they array is empty if none are found.
    ///
    /// - note: `self` need not be sorted.
    func findGaps(stride: Int = 1,
                  inRange range: ClosedRange<Int>? = nil) -> [Gap] {
        
        let (data, range) = gapParams(inRange: range)
        
        return GapFinder.find(in: data,
                              stride: stride,
                              usingRange: range)
                
        
    }
    
    /// Creates formatted representations of any gaps found in `self`
    ///
    /// ```
    ///    // -------------------
    ///    // Sample Output:
    ///    // -------------------
    ///    //  array:    [1,2,6]
    ///    //  range:    1..6
    ///    //  stride:   1
    ///    // - - - - - - - - - -
    ///    //
    ///    // standard      compact
    ///    //
    ///    //   ┌───┐       Gaps:
    ///    //   │ 1 │       [ 3 ]  ← 3 →  [ 5 ]
    ///    //   │ ⇣ │
    ///    //   │ 2 │
    ///    //   └───┘
    ///    //     3
    ///    //     ⇣
    ///    //     5
    ///    //   ┌───┐
    ///    //   │ 6 │
    ///    //   └───┘
    ///    //
    ///    // Note: 
    ///    // * standard - shows the non-gaps(bordered) and gaps(unbordered)
    ///    //
    ///    // * compact  - shows only the missing values with the number of
    ///    //              elements missing(3 here) displayed in the center
    ///    //              between the two arrows.
    /// ```
    func describeGaps(stride: Int? = nil,
                      inRange range: ClosedRange<Int>? = nil,
                      compactFormat: Bool = false) -> String {
        
        let stride = stride ?? 1 // Default
        
        let (data, range)   = gapParams(inRange: range)
        
        let gaps            = GapFinder.find(in: data,
                                             stride: stride,
                                             usingRange: range)
        
        if compactFormat {
            
            return GapFinder.compactDescribe(gaps: gaps,
                                             inRange: range)   /*EXIT*/
            
        } else {
            
            return GapFinder.describe(gaps: gaps,
                                      stride: stride,
                                      inRange: range)   /*EXIT*/
            
        }
        
    }
    
}


// - MARK: GapFinder (private)
/// Private class for finding gaps(non-consecutive values)  in Arrays of `GapFindable`s
///
/// - important: This class should not be used directly, instead have your array
/// `Element` adopt GapFindable, then call the array extension methods to tap into
/// finder functionality.
fileprivate struct GapFinder {
    
    /// Finds and returns a list of all `Gap`s contained in sequence `in`
    /// - Parameters:
    ///   - toCheck: sequence of presumed consecutive `Int`s to be checked for
    ///   "gaps" in consecutivity.
    ///   - stride: the expected difference between consecutive elements.
    ///   - usingRange: the range of `Int` to consider when checking for consecuitivy.
    /// - Returns: An array of `Gap`s
    fileprivate static func find(in toCheck: [Int],
                            stride: Int,
                            usingRange: ClosedRange<Int> ) -> [Gap] {
        
        lastNonGapValue   = usingRange.lowerBound - stride
        
        var toCheck     = toCheck
        
        let upperBound  = usingRange.upperBound + stride
        toCheck.append(upperBound)
        toCheck.sort()
        
        var gaps        = [Gap]()
        
        for checking in toCheck {
            
            if checking > upperBound { break /*BREAK*/ }
            if checking < lastNonGapValue { continue /*CONTINUE*/ }
                
            if let gap = check(nonGapValue: checking,
                               stride: stride) {
                
                gaps.append(gap)
                
            }
            
        }
        
        return gaps
        
    }
    
    ///The last non-gap-value found in sequence.
    private static var lastNonGapValue = 0
    
    /// Used for formatting text output.
    fileprivate static var paddWidth: Int { lastNonGapValue.descriptionCharCount + 4 }
    
    
    /// Checks for consecutivity between `nonGapValue` and `lastNonGapValue` returning a `Gap` if found.
    /// - Parameters:
    ///   - currentNonGapValue: current value to check against last nonGapValue for consecutivity.
    ///   - stride: expected difference between values of two consecutive non-gap-values.
    /// - Returns: `Gap` representing the distance in strides between `nonGapValue`
    /// and the `lastNonGapValue` or nil if they are consecutive.
    private static func check(nonGapValue currentNonGapValue: Int,
                              stride: Int) -> Gap? {
        
        let strideLength = currentNonGapValue - lastNonGapValue
        
        assert(stride >= 0, "")
        
        assert(strideLength >= 0,
               "Expected stride length: \(stride) or 0 - Actual stride length: \(strideLength)")
        
        assert(strideLength % stride == 0,
               "strideLength % stride != 0  (\(strideLength) % \(stride) = \(strideLength % stride))")
        
        if strideLength > stride {
            
            let gap = Gap(lastNonGapValue + stride, currentNonGapValue - stride, stride: stride)
            
            lastNonGapValue = currentNonGapValue // Update
            
            return gap
            
        }
        
        lastNonGapValue = currentNonGapValue // Update
        
        return nil
        
    }
    
    /// Creates a visual representation of missing elements in sequence.
    /// - note: this version of a `describe()` method,  shows both gaps 
    /// *and* non-gaps. Gaps are depicted as ranges without borders, consecutive
    /// non-gap-values  are shown as bordered ranges.
    fileprivate static func describe(gaps: [Gap],
                                     stride: Int = 1,
                                     inRange range: ClosedRange<Int>) -> String {
        
        if gaps.count == 0 { return Gap.noneFound /*EXIT*/ }
        
        var output      = ""
        let paddWidth   = paddWidth - 2
        let line        = String(repeating:"─", count: paddWidth)
        let top         =   "┌\(line)┐\n"
        let bot         = "\n└\(line)┘\n"
        
        var lastNum = -1
        
        func centered(_ num: Int, isTop: Bool) -> String {
            
            var centered    = num.description.centerPadded(toLength: paddWidth)
            let arrow       = "⇣".centerPadded(toLength: paddWidth)
            
            if isTop {
                
                centered = "\(top)│\(centered)│"
                
            } else {
                
                if lastNum == num {
                    
                    centered = "\(bot)"
                    
                } else if num == range.lowerBound {
                    
                    centered = "\(top)│\(centered)│\(bot)"
                    
                } else {
                    
                    centered = "\n│\(arrow)│\n│\(centered)│\(bot)"
                    
                }
                
            }
            
            lastNum = num
            
            return centered
            
        }
        
        var needsBottom = false
        
        // Edge Case: first 2+ items are present
        if gaps.first!.lowerMissingValue > range.lowerBound + stride {
        
            output   += centered(range.lowerBound, isTop: true)
            
        }
        
        for gap in gaps {
            
            let prev = gap.lowerMissingValue - stride
            let next = gap.upperMissingValue + stride
            
            if prev >= range.lowerBound {
                
                output   += centered(prev, isTop: false)
                
                needsBottom = false
                
            }
            
            output += gap.description
            
            if next < range.upperBound + stride {
                
                output += centered(next, isTop: true)
                
                needsBottom = true
                
            }
            
        }
        
        // Edge Case: last number
        let lastValue = range.upperBound
        if gaps.last!.upperMissingValue < lastValue {
        
            output   += centered(lastValue, isTop: false)
            needsBottom = false
            
        }
        
        output += needsBottom ? bot : ""
        
        return output
    }
    
    /// Creates a more horizontally compact `String` representation of all missing
    /// elements compared to `describe(gaps:)`
    /// - note: this version of a `describe()` method, shows only gaps and not
    /// existing non-gap elements.
    fileprivate static func compactDescribe(gaps: [Gap],
                                       inRange range: ClosedRange<Int>) -> String {
        
        var output = ""
        
        for gap in gaps {
            
            output += "\(gap.descriptionSimple)\n"
            
        }
        
        if !output.isEmpty {
            
            output = "Gaps:\n\(output)"
            
        }
        
        return output
        
    }
    
}
