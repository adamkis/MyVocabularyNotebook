//
//  Calculator.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 11. 15..
//  Copyright © 2017. Adam. All rights reserved.
//

import Foundation

class Calculator{
    
    func add(input: String) -> Int? {
        print("--------Adding started. Input: \(input)")
        var sum: Int = 0
        if input.count < 1 {
            return 0
        }
        
        let inputArray = input.components(separatedBy: ",")
        
        for inputElement in inputArray{
            print("Element: \(inputElement)")
            guard let inputInt = Int(inputElement) else {
                return nil
            }
            sum += inputInt
        }
        print("---------Adding ended with output. Sum: \(sum)")
        return sum
    }
    
}
