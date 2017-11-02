//
//  Utils.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 09. 16..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit
import os.log

class Utils: NSObject {

    open class func log(_ input: StaticString){
        os_log(input, log: OSLog.default, type: .default)
    }
    
    open class func print(_ input: Any){
        Swift.print(input)
    }
    
    // return minimum value in a list of Ints
//    open class func min(numbers: Int...) -> Int {
//        return numbers.reduce(numbers[0], {$0 < $1 ? $0 : $1})
//    }
    
    open class func levenshtein(aStr: String, bStr: String) -> Int {
        
        // Empty String error handling - TODO fix it properly later
        var aStringValue = aStr
        var bStringValue = bStr
        if aStringValue.count < 1 {
            aStringValue = "⬜"
        }
        if bStringValue.count < 1 {
            bStringValue = "⬜"
        }
        // create character arrays
        let a = Array(aStringValue)
        let b = Array(bStringValue)
        
        // initialize matrix of size |a|+1 * |b|+1 to zero
        var dist: [[Int]] = [[Int]]()
        for _ in 0...a.count {
            dist.append([Int](repeating: 0, count: b.count + 1))
        }
        
        // 'a' prefixes can be transformed into empty string by deleting every char
        for i in 1...a.count {
            dist[i][0] = i
        }
        
        // 'b' prefixes can be created from empty string by inserting every char
        for j in 1...b.count {
            dist[0][j] = j
        }
        
        for i in 1...a.count {
            for j in 1...b.count {
                if a[i-1] == b[j-1] {
                    dist[i][j] = dist[i-1][j-1]  // noop
                } else {
                    dist[i][j] = Swift.min(
                        dist[i-1][j] + 1,  // deletion
                        dist[i][j-1] + 1,  // insertion
                        dist[i-1][j-1] + 1  // substitution
                    )
                }
            }
        }
        
        return dist[a.count][b.count]
    }
    
    open class func levenshteinRatio(aStr: String, bStr: String) -> Double {
        let average: Double = (Double(aStr.count) + Double(bStr.count)) / 2
        return (Double(levenshtein(aStr: aStr, bStr: bStr)) / average)
    }
    
    open class func wasGuessRight(aStr: String, bStr: String) -> Bool {
        return levenshteinRatio(aStr: aStr, bStr: bStr) < 0.5
    }
    
}
