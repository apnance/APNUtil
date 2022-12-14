//
//  Array.swift
//  APNUtil
//
//  Created by Aaron Nance on 11/14/17.
//  Copyright © 2017 Nance. All rights reserved.
//

import UIKit
import MobileCoreServices

public protocol Copyable { func copy() -> Copyable }

public extension Array {

    static func += (lhs: inout Array, rhs: Array) { lhs = lhs + rhs }
    
    /// Returns !isEmpty
    var isNotEmpty: Bool { !isEmpty }
    
    /// Returns the index of the last element in the array or -1
    /// if the array is empty.
    var lastUsableIndex: Int { count - 1 }
    
    /// Returns the second element in `self` or null if `self.count < 2`
    var second: Element? {
        
        if self.count < 2 { return nil }
        else { return self[1] }
        
    }
    
    /// Returns the second to last element in `self` or null if `self.count < 2`
    var secondToLast: Element? {
        
        if self.count < 2 { return nil }
        else { return self[count - 2 ] }
        
    }
    
    /// Returns the index of the center Element(count / 2) or -1 if array is empty.
    /// - note: if the array contains an even number of Elements the center is calculated to be the node just right of the center.
    /// ````
    ///     // e.g.
    ///     ["A","B","C","D"].centerIndex == 2  // Points to "C"
    ///     ["A","B","C"].centerIndex == 1      // Points to "B"
    /// ````
    var centerIndex: Int { isEmpty ? -1 : count / 2 }

    /// Returns the `Element` with `index == centerIndex` or `nil` if `centerIndex` < 0
    var centerElement: Element? { centerIndex >= 0  ? self[centerIndex] : nil }

    /// Same as `centerIndex` except it considers the center of even numbered arrays to be the Element to left of center.
    /// ````
    ///     // e.g.
    ///     ["A","B","C","D"].centerLeftIndex == 1  // Points to "B"
    ///     ["A","B","C"].centerLeftIndex == 1      // Points to "B"
    /// ````
    var centerLeftIndex: Int { isEmpty ? -1 : lastUsableIndex / 2}
    
    /// Returns the `Element` with `index == centerLeftIndex` or `nil` if `centerLeftIndex` < 0
    var centerLeftElement: Element? { centerLeftIndex >= 0  ? self[centerLeftIndex] : nil }
    
    /// Returns a `Bool` indicating if the specified index is with the `Array`'s bounds.
    func isInBounds(index: Int) -> Bool {
        
        count > 0 && index >= 0 && index < count
        
    }
    
    /// Returns a `Bool` indicating if the *all* of the specified indices are within the `Array`'s bounds.
    func areInBounds(indices: [Int]) -> Bool {
        
        for index in indices {
            
            if !isInBounds(index: index) { return false /*EXIT*/ }
            
        }
        
        return true /*EXIT*/
        
    }
    
    /// Returns the `Array` `Element` preceding the specfied `index` or `nil` if the
    /// `index` is not within the `Array`'s bounds.
    func elementPreceding(index: Int) -> Element? {
        
        isInBounds(index: index &- 1) ? self[index - 1] : nil
        
    }
    
    /// Pads an array to final count using Element specified in with argument.
    mutating func padTo(finalCount: Int, with filler:Array.Element){
        
        if self.count >= finalCount { return /*EXIT*/ }
        
        for _ in 0..<(finalCount - self.count) {
            self.append(filler)
        }
    }
    
    /// Pads an `Array` to finalCount # of elements by appending elements plucked randomly from w/in itself.
    mutating func padSelfRandomly(finalCount: Int) {
        
        self = expandSelfRandomly(finalCount: finalCount)
        
    }
    
    /// Attempts to return a sub-Array using specified start and end bounds.
    /// - returns: a sub-`Array` starting at `start` index and ending at `end` index.
    /// - important: array bounds not checked.
    func sub(start: Int, end: Int) -> Array {
        
        let start   = Swift.max(0, start)
        let end     = Swift.max(start, Swift.min(end, self.count - 1))
        
        return Array(self[start...end])
        
    }
    
    /// Returns a copy of the `Array` expanded to `finalCount` using `Element`  specified in `with` argument.
    func expandTo(finalCount: Int, with filler:Array.Element) -> Array{
        
        var current = self
        
        if current.count >= finalCount { return current /*EXIT*/ }
        
        for _ in 0..<(finalCount - current.count) {
            current.append(filler)
        }
        
        return current
    }
    
    /// Returns a copy of the `Array` expanded to `finalCount` of elements by appending elements
    /// plucked randomly from within itself.
    ///
    /// - important: `Arrays` of `Class` ojbects should adopt/conform to `Copyable` protocol.
    func expandSelfRandomly(finalCount: Int) -> Array {
        
        var current = self
        let first = current.first!
        
        let needsCopy = first is Copyable
        
        while current.count < finalCount {
            
            let random = current.randomElement()!
            
            if needsCopy {
               
                current.append((random as! Copyable).copy() as! Element)
                
            } else {
            
                current.append(random)
                
            }
            
        }
        
        return current
        
    }
    
    /// Returns a copy of self with left half mirrored to right half.
    /// ```
    ///     //Ex.
    ///     [1,2,3,4].mirror()      // returns [1,2,2,1]
    ///     [1,2,3,4,5].mirror()    // returns [1,2,3,4,5]
    ///
    /// ```
    func mirror() -> Array {
        
        if count < 2 { return self }
        
        let left = sub(start: 0, end: (count - 1) / 2)
        var right = Array(left.reversed())
        
        if count % 2 == 1 {
            
            right = Array(right.dropFirst())
            
        }
        
        return left + right
        
    }
    
    /// Returns a copy of `self` with `newElement` appended.
    /// - Parameter newElement: new `Element` to append to copy.
    /// - Returns: a copy of `Self` with `Element` `el` appended.
    func appending(_ newElement: Element) -> [Element] {
        
        var copy = self
        copy.append(newElement)
        
        return copy
        
    }
    
}


// MARK: - Array<Int>
public extension Array where Element == Int {
    
    /// Returns a `Double` representing the percent the specified Int is of the sum of all `Ints` in the `Array<Int>`.
    func percent(index i: Int, roundedTo digits: Int = 2) -> Double? {
        
        let sum = self.sum()
        
        guard sum > .zero, i <= lastUsableIndex
        else { return nil /*EXIT*/ }
        
        var percent = (Double(self[i]) / Double(sum)) * 100
        
        if digits >= 0 {
            percent = percent.roundTo(digits)
        }
        
        return percent
        
    }
}

// MARK: - Array<String>
public extension Array where Element == String {

    /// Returns copy of the `Array<String>` with all `Elements` lowercased.
    func lowercased() -> [String] { self.map{ return $0.lowercased() } }
    
    /// Returns copy of the `Array<String>` with all `Elements` uppercased.
    func uppercased() -> [String] { self.map{ return $0.uppercased() } }

    /// Returns a copy of the `Array<String>` with all `Elements` trimmed of leading/trailing whitespace.
    func trimmed() -> [String] { self.map{ return $0.trim() } }
    
    ///  Returns a copy of the `Array<String>` with all `Elements`lowercased and with all spaces removed.
    func lowerNoSpaces() -> [String] { self.map{ return String.lowerNoSpaces($0) } }
    
}

// MARK: - Array<CustomStringConvertible>
public extension Array where Element : CustomStringConvertible {
    
    func printSimple() { forEach{ print($0) } }
    
}


// MARK: - Array<Comparable>
public extension Array where Element : Comparable {
    
    /// Attempts to find and return the next element in the sorted Array bigger than `compareTo`
    /// - parameter compareTo: `Element` to compare against each `Element` in the sorted `Array`.
    /// - returns: The first `Element` greater than `compareTo` if found, else `first` if count > 0, else nil
    /// - note: returns `nil` for empty `Arrays`
    func cycleBigger(_ compareTo: Element) -> Element? {
        
        let sorted = self.sorted(by: < )
        
        for element in sorted {
            
            if compareTo < element { return element /*EXIT*/ }
            
        }
        
        return sorted.first /*EXIT*/
        
    }
    
    /// Attempts to find and return the next element in the sorted Array smaller than `compareTo`
    /// - parameter compareTo: `Element` to compare against each `Element` in the sorted `Array`.
    /// - returns: The first `Element` smaller than `compareTo` if found, else `last` if count > 0, else nil
    /// - note: returns `nil` for empty `Arrays`
    func cycleSmaller(_ compareTo: Element) -> Element? {
        
        let sorted = self.sorted(by: >)
        
        for element in sorted {
            
            if compareTo > element {
                
                return element /*EXIT*/
                
            }
            
        }
        
        return sorted.first /*EXIT*/
        
    }
    
}

// MARK: - Array<Equatable>
public extension Array where Element: Equatable {
    
    func countOf(_ element: Element) -> Int {
        
        self.reduce(0) { $1 == element ? $0 + 1 : $0 }
        
    }
    
    /// Removed duplicate elements while maintaining order.
    func dedupe() -> Array {
        
        return reduce(into: []) {
            
            result, element in
            
            result.appendUnique(element)
            
        }
        
    }
    
    /// Appends the specified `element` to the array if the array does not already contain a
    /// matching `Element`
    mutating func appendUnique(_ element: Element) {
        
        if !contains(element) { append(element) }
        
    }
    
    /// Removes the specified `Element(s)` from the `Array` if found.
    mutating func remove(_ element: Element) {
        
        self = self.filter{ $0 != element }
        
    }
    
    /// Returns the closed range representing all elements of array.
    /// Suitable for iterating over the array.
    var usableRange: ClosedRange<Int>? {
        guard lastUsableIndex >= 0
            else { return nil /*EXIT*/ }
        
        return 0...lastUsableIndex
        
    }
    
    /// Returns random optional Int representing a valid array index.
    var randomIndex: Int? {
        guard let range = usableRange
            else { return nil /*EXIT*/ }
        
        return Int.random(in: range)
        
    }
    
    /// Returns random optional element from the array.
    var randomElement: Element? {
        guard let index = randomIndex
        else { return nil /*EXIT*/ }
        
        return self[index]
        
    }
    
    /// Returns an integer representing the number of unique Elements in the array.
    var uniques: Int { dedupe().count }
    
    /// Returns a bool indicating whether the array contains only unique elements
    ///
    /// i.e. contains no duplicate Element
    var allUniques: Bool { count == dedupe().count }
    
    /// Returns an arr  ay of elements randomly plucked from this array.
    ///
    /// Note: uniqueness is aspirational and not guaranteed, check the
    /// returned array's allUniques
    func randomUniqueElements(numberOfElements num: Int) -> [Element]? {

        guard self.count > 0
        else { return nil /*EXIT*/ }
        
        var randoms = dedupe().shuffled()
    
        // If randoms.count < num, pad randoms with random elements plucked
        // from within itself
        randoms.padSelfRandomly(finalCount: num)
    
        return randoms
        
    }
    
    /// Returns an array of elements randomly plucked from this array which contains a maximum
    /// number of elements as specified by maxElements.
    func randomUniqueElements(maxElements max: Int) -> [Element] {
        
        guard self.count > 0
            else { return [] /*EXIT*/ }
        
        let randoms = dedupe().shuffled()
        
        if randoms.count > max {
            
            return randoms.first(x: max)!
            
        }
        
        return randoms /*EXIT*/
        
    }
    
    /// Returns the first x elements of the array.
    ///
    /// Note: if the array count is less than x the
    /// array is returned.  The array is not padded to x.
    func first(x: Int) -> [Element]? {
        
        assert(x >= 0)
        
        if x >= count {
            
            return self /*EXIT*/
            
        } else {
            
            let numToDrop = count - x
            
            return self.dropLast(numToDrop) /*EXIT*/
            
        }
        
    }
    
    /// Returns the specified number of elements plucked randomly from the array.
    func randomElements(numberOfElements: Int) -> [Element]? {
        var randoms = [Element]()

        guard self.count > 0
        else { return nil /*EXIT*/ }
        
        for _ in 0..<numberOfElements {
            randoms.append(self.randomElement!)
        }
        
        return randoms
        
    }
    
    /// Attempts to get the Element at the provided index.  If the array is empty it returns nil, if the array is
    /// not empty but the index is greater than the the index of the last item in the array, the last item is returned.
    func nearestElementTo(index: Int) -> Element? {
        if isEmpty { return nil /*EXIT*/ }
        
        if index <= lastUsableIndex {
            
            return self[index] /*EXIT*/
            
        } else {
            
            return  self.last /*EXIT*/
            
        }
        
    }
    
    /// Returns the an array from the current array that excludes all element specified in the argument.
    func excluding(_ toExclude:[Element]) -> [Element] {
        
        var excluding = [Element]()
        
        for element in self {
            
            if !toExclude.contains(element) {
                
                excluding.append(element)
                
            }
            
        }
        
        return excluding
        
    }
    
    /// Pulls a specified number of elements randomly from an array.  Elements that are selected are
    /// then excluded from subsequent random selections meaning that there will be no duplicates.
    func randomElementsFromWeighted(_ numElements: Int) -> [Element] {
        
        var numKeys = numElements
        var randomKeys = [Element]()
        
        var weightedArray = self
        
        while numKeys > 0 && weightedArray.count > 0 {
            
            // Get/Add random element
            let randElement = weightedArray.randomElement()!
            randomKeys.append(randElement)
            
            // Prepare for next iteration
            weightedArray.removeAll{$0 == randElement}
            numKeys -= 1
            
        }
        
        return randomKeys
        
    }
    
}

// MARK: - Array<Hashable>
public extension Array where Element : Hashable {
    
    /**
     Creates and returns  an `[Element: Int] Dictionary` from the given `Array` with the value
     being set to a value equal to the number of occurences of the each `Element` in the `Array`.
     ```
     // ex.
     
     let fruitArray = ["apple", "apple", "apple", "banana", "banana", "orange", "pear"]
     let fruitDict = fruitArray.dictionaryFromWeightedArray()
     
     // result:
     // fruitDict == ["apple": 3, "banana": 2, "orange":1, "pear": 1]
     //
     ```
     - returns: a Dictionary with keys corresponding to the distinct Elements of the Array and values
     representing the number of occurences of each Element in the Array.
     */
    func dictionaryFromWeightedArray() -> [Element: Int] {
        
        let dict = reduce([Element:Int]()){ (d, e) -> [Element: Int]
            in
            
            var d = d
            d.add(e, 1)
            
            return d
        }
        
        return dict
        
    }
    
    /// Replaces all `Elements` with the result of calling applying()  on those `Elements`.
    ///
    /// - parameter applying: a closure that takes a string and returns a string.  this closure is called
    /// on each `Element` in the `Array` replacing old values with newly generated values.
    ///
    /// ```
    /// // ex.
    /// var colors = Set<String>(["RED","YeLlOw","BLue"])
    ///
    ///     colors.clean( { $0.lowercased() } )
    ///
    /// // Result: ["red","yellow","blue"]
    ///```
    ///
    mutating func clean(_ applying: (Element) -> Element)  {
                
        for (i, element) in self.enumerated() {
            
            let element = applying(element)
            
            self[i] = element
            
        }
        
    }
    
}

// MARK: - Array<AdditiveArithmetic>
public extension Array where Element : AdditiveArithmetic {
    
    /// Adds each Elements in to array to the Element in self of same index.
    /// - Note: arrays must be same length
    /// ex.
    /// ````
    /// var ar1 = [1,3,100]
    /// let ar2 = [0,4,2]
    /// ar1.addEach(ar2)
    ///
    /// ar1 == [1,7,102] // true
    mutating func addElements(_ from: Array<Element>) {
        
        assert(self.count == from.count)
        
        for i in 0...self.lastUsableIndex {
            
            self[i] += from[i]
            
        }
        
    }
    
}

// source: https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift
public extension MutableCollection {
    
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        
        fatalError("\(#function) deprecated. Use Array.shuffle().")
        
        /*
        let c = count
        guard c > 1 else { return }
         
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
         
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
         
        }
        */
        
    }
    
}

public extension Array where Element: UIImage {
    
    // Source:
    // https://stackoverflow.com/questions/45745432/ios-11-animated-gif-display-in-uiimageview
    func animatedGif() {
        let fileProperties: CFDictionary    = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]  as CFDictionary
        let frameProperties: CFDictionary   = [kCGImagePropertyGIFDictionary as String: [(kCGImagePropertyGIFDelayTime as String): 1.0]] as CFDictionary
        
        let documentsDirectoryURL: URL? = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL: URL? = documentsDirectoryURL?.appendingPathComponent("animated.gif")
        
        if let url = fileURL as CFURL? {
            
            if let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, self.count, nil) {
                CGImageDestinationSetProperties(destination, fileProperties)
                for image in self {
                    
                    if let cgImage = image.cgImage {
                        
                        CGImageDestinationAddImage(destination, cgImage, frameProperties)
                        
                    }
                    
                }
                
                if !CGImageDestinationFinalize(destination) {
                    
                    print("Failed to finalize the image destination")
                    
                }
                
                print("Url = \(String(describing: fileURL))")
                
            }
            
        }
        
    }
    
    func animate(in targetImageView: UIImageView,
                 withRepeatCount repeatCount: Int = 1,
                 delay: Double = 0.1,
                 fps: Double = 120) {
        
        targetImageView.animationImages         = self
        targetImageView.image                   = last!
        targetImageView.animationRepeatCount    = repeatCount
        targetImageView.animationDuration       = Double(count) / fps
        targetImageView.startAnimating()
    }
    
}
