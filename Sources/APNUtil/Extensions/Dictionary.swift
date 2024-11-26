//
//  Dictionary.swift
//  APNUtil
//
//  Created by Aaron Nance on 9/22/19.
//  Copyright © 2019 Aaron Nance. All rights reserved.
//

import Foundation

public extension Dictionary {

    /// Effectively swaps `old` `Key` with `new` `Key` retaining original value.
    ///
    /// - parameter old: key value to replace.
    /// - parameter new: key value to replace `old` with.
    ///
    mutating func swapKey(_ old: Key,_ new: Key) {

        let value = self[old]
        self.removeValue(forKey: old)
        
        self[new] = value
        
    }

    /// Prints the dictionary in very simple easy to read format
    ///
    /// ex.
    ///
    /// "apple": 1
    /// "banana": 0
    /// "orange": 3
    ///
    func printSimple() { forEach { print("\($0): \($1)") } }

}

// MARK: - Numeric
public extension Dictionary where Value : Numeric {
    
    /// Returns `values` converted to ` Array<values.Self>`
    ///
    /// - important: values are not returned in a guaranteed order.
    var valueArray: Array<Value> {
        
        Array(values)
        
    }
    
    /// The sum of all `Int` `Values`
    var sum: Value { reduce(Value.zero) { $1.value + $0 } }

    /// Adds the the values of items sharing same key, otherwise inserts new items into self.
    ///
    /// # Example #
    /// ```swift
    /// var d1 = ["a": 1, "b": 2, "c:" 3]
    /// let d2 = ["a": 4, "c": -3, "d": 10]
    /// d1.add(d2) // d1 now == ["a": 5, "b":2, "c": 0, "d": 10]
    /// ```
    mutating func add(_ from: [Key : Value]) {
        
        for (key, value) in from {
            
            self.add(key, value)
            
        }
        
    }
    
    /// Adds a new key/value combination unless already exists.  If the key exists
    /// the value is set to the sum of the old value and the new value specified
    /// as the second argument.
    ///
    /// - Parameter key: Key of entry to create/update
    /// - Parameter value: value to use for new dictionary element or add to existing,
    ///     defaults to 1 if unspecified.
    ///
    mutating func add(_ key: Key, _ value: Value = 1) {
        
        if let oldValue = self[key] {
            
            self[key] = oldValue + value
            
        } else { self[key] = value }
        
    }
    
    /// calls `add(key: Key, value: Int)`  with `value` for each `Key` in keys
    ///
    /// - Parameter keys: Array of `Key` of entries  to create/update
    /// - Parameter value: value to use for new dictionary element or add to existing.
    ///
    mutating func add(_ keys: [Key], _ value: Value) {
        
        keys.forEach { add($0, value) }
        
    }
    
    /// Decrements the `Value` by `value`.  If the key is not found this method does nothing.
    ///
    /// - Parameter key: Key of entry to decrement
    /// - Parameter value: amount to decrement `Value` by
    ///
    mutating func subtract(_ key: Key, _ value: Value) {
        
        guard let oldValue = self[key]
        else { return /*EXIT*/ }
        
        self[key] = oldValue - value
        
    }
    
    /// Decrements the `Value`s  by `value` for each `Key` in [keys].
    ///
    /// - Parameter [keys]: `array` of Keys decrement
    /// - Parameter value: amount to decrement `Value` by
    ///
    mutating func subtract(_ keys: [Key], _ value: Value) {
        
        keys.forEach { subtract($0, value) }
        
    }
    
    /// Returns a copy of Self with each value multiplied by `factor`
    func eachTimes(_ factor: Value) -> [Key : Value] {
        
        var product = [Key : Value]()
        
        for (k,v) in self {
            
            product[k] = v * factor
            
        }
        
        return product
    }
    
    /// Sets all values to zero, retaining keys
    mutating func zero() {
        
        for (key,_) in self { self[key] = 0 }
        
    }

    /// Returns a copy of the dictionary with all values set to zero.
    func zeroCopy() -> [Key : Value] {
        
        var copy = self
        copy.zero()
        
        return copy
        
    }
    
}

// MARK: - Int
public extension Dictionary where Value == Int {
    
    /// Returns the percentage the Int at `Key` is of the sum of all `Int` `Values
    ///
    /// - Parameter key: Key of the entry to calculate percentage of total for.
    func percent(_ key: Key, roundedTo digits: Int = 2) -> Double? {
        
        let val = self[key]
        let vals = valueArray
        
        for (i,v) in vals.enumerated() {
            
            if val == v {
                
                if let percent = vals.percent(index: i, roundedTo: -1) {
                    
                    return percent.roundTo(digits) /*EXIT*/
                    
                } else {
                    
                    return nil /*EXIT*/
                    
                }
            }
        }
        
        return nil /*EXIT**/
        
    }
    
    /// Returns an array of [Key] where each key is repeated a number of times equal to value.
    /// For values less than 1, the key is omitted from result.
    ///
    /// ex.
    ///
    /// let fruit = ["apple": 3, "orange": 1, "banana": 2, "kiwi": -1, "cherry": 0]
    /// let weightedFruitArray =  fruit.weightedArray()
    ///
    /// result:
    /// weightedFruitArray ==  ["apple", "apple", "apple", "orange", "banana", banana"]
    ///
    /// Note: "kiwi" and "cherry" are not included in result.
    ///
    func weightedArray() -> [Key] {
        
        var wa = [Key]()
        
        for (key , value) in self {
            
            let value = value <= 0 ? 0 : value
            wa += Array(repeating: key, count: value)
            
        }
        
        return wa
        
    }
    
    /// Returns a random Key from the [Key:Int] dictionary.
    func randomKeyFromWeighted() -> Key? { self.weightedArray().randomElement }
    
    
    /// Returns and array of keys pulled randomly from the dictionary's weightedArray.
    ///
    /// ex. let fruit = ["apple" : 1, "banana" : 3, "orange" : 0]
    /// returns ["apple", "banana", "banana", "banana", ]
    func randomKeysFromWeighted(_ numKeys: Int) -> [Key] { return weightedArray().randomElementsFromWeighted(numKeys) }
    
    /// Returns the percentage of each value of the sum of all values for each key.
    func percentages(roundedTo: Int = Int.max) -> [Key : Double] {
        
        var percentages = [Key: Double]()
        let sum = self.sum
        
        for (key, value) in self {
            
            var percent = (Double(value) / Double(sum)) * 100.0
            
            if roundedTo < Int.max {
                percent = percent.roundTo(roundedTo)
            }
            
            percentages[key] = percent
            
        }
        
        return percentages
        
    }
}

// MARK: - Key == String
public extension Dictionary where Key == String {

    /// Replaces all `Key`-s  values with the result of calling applying()  on those `Key`-s.
    ///
    /// - parameter applying: a closure that takes a string and returns a string.  this closure is called on each
    /// `Key` in the `[Key:String]` `Dictionary`  replacing old `Key`-s with newly generated ones.
    ///
    /// # Example #
    /// ```swift
    /// // ex.
    /// var colors = [ "RED" : 1, "YeLlOw" : 2, "BLue" : 3 ])
    ///
    ///     colors.cleanKeys( { $0.lowercased() } )
    ///
    /// // Result: [ "red" : 1, "yellow" : 2, "blue" : 3 ]
    ///```
    ///
    mutating func cleanKeys(_ applying: (String) -> String) {
        
        for old in self.keys {
            
            let new = old.processed(applying)
            
            self.swapKey(old, new)
        }
        
    }
    
}

// MARK: - Values are Arrays
public extension Dictionary where Value == [Any] {
    
    /// Inserts a new value to the array for the given key if the key exists in the dictionary.
    /// If the key does not exist, creates a new array with the given value and assigns it to the dictionary.
    ///
    /// - Parameters:
    ///   - value: The value to insert or to create a new array with.
    ///   - key: The key for which to insert the new value.
    mutating func insert(_ value: Any, atKey key: Key) {
        if var existingArray = self[key] {
            // If the key exists, insert the new value to the existing array.
            existingArray.append(value)
            self[key] = existingArray
        } else {
            // If the key does not exist, create a new array with the given value and assign it to the dictionary.
            self[key] = [value]
        }
    }
    
    /// Removes all instances of a value from the array for the given key if the value exists in the array.
    /// Returns a list of all removed values if any were found and removed, otherwise returns nil.
    ///
    /// - Parameters:
    ///   - value: The value to remove from the array.
    ///   - key: The key for which to remove the value.
    /// - Returns: An array of removed values if any were found and removed, otherwise nil.
    @discardableResult
    mutating func remove<T: Equatable>(_ value: T, forKey key: Key) -> [T]? {
        // Check if the key exists in the dictionary and the associated value is an array of the expected type.
        if var existingArray = self[key] as? [T] {
            // Remove all instances of the value from the array.
            let removedValues = existingArray.filter { $0 == value }
            existingArray.removeAll { $0 == value }
            // Update the dictionary with the modified array.
            self[key] = existingArray as? Value
            return removedValues.isEmpty ? nil : removedValues
        }
        // Return nil if the key or value does not exist.
        return nil
    }
    
    // TODO: Clean Up - delete
    
    //    /// Appends a new value to the array for the given `key` if the `key` exists in the `self`.
    //    /// If the `key` does not exist, creates a new `array` with the given value and assigns it to the
    //    /// `self` under `key`
    //    ///
    //    /// - Parameters:
    //    ///   - value: The value to append or to create a new array with.
    //    ///   - atKey: The key for which to append the new value.
    //    mutating func insert(_ value: Any, atKey key: Key) {
    //
    //        if var existing = self[key] {
    //
    //            // Append
    //            existing.append(value)
    //            self[key] = existing
    //
    //        } else {
    //
    //            // Create
    //            self[key] = [value]
    //
    //        }
    //
    //    }
    //
    //    /// Removes a value from the array for the given `key` if the value exists in the array.
    //    /// Returns the removed value if it was found and removed, otherwise returns `nil`.
    //    ///
    //    /// - Parameters:
    //    ///   - value: The value to remove from the array.
    //    ///   - forKey: The key for which to remove the value.
    //    /// - Returns: The removed value if it was found and removed, otherwise nil.
    //    mutating func remove<T: Equatable>(_ value: T, forKey key: Key) -> T? {
    //
    //        // Check if the key exists in the dictionary
    //        if var existingArray = self[key] as? [T] {
    //
    //            // Remove the value from the array
    //            existingArray.removeAll { $0 == value }
    //
    //            // Update the dictionary
    //            self[key] = existingArray as? Value
    //
    //            return value    // EXIT
    //
    //        } else {
    //
    //            return nil      // EXIT
    //
    //        }
    //
    //
    //    }
    
}
