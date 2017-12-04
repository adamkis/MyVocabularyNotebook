//
//  MyPhraseBookTests.swift
//  MyPhraseBookTests
//
//  Created by Adam on 2017. 08. 29..
//  Copyright © 2017. Adam. All rights reserved.
//

import XCTest
@testable import MyPhraseBook

class MyPhraseBookTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLevenshteinSameWord(){
        let sameWordsDistance = Utils.levenshtein(aStr: "Cat", bStr: "Cat")
        XCTAssertEqual(sameWordsDistance, 0)
    }
    
    
    func testLevenshteinAllCharactersDifferent3Characters(){
        let sameWordsDistance = Utils.levenshtein(aStr: "Cat", bStr: "Dog")
        XCTAssertEqual(sameWordsDistance, 3)
    }
    
    func testLevenshteinAllCharactersDifferent4Characters(){
        let sameWordsDistance = Utils.levenshtein(aStr: "Door", bStr: "cat")
        XCTAssertEqual(sameWordsDistance, 4)
    }
    
    func testLevenshteinRatioSameWord(){
        let sameWordsDistance = Utils.levenshteinRatio(aStr: "Cat", bStr: "Cat")
        XCTAssertEqual(sameWordsDistance, 0)
    }
    
    
    func testLevenshteinRatioAllCharactersDifferent(){
        let sameWordsDistance = Utils.levenshteinRatio(aStr: "Cat", bStr: "Dog")
        XCTAssertEqual(sameWordsDistance, 1)
    }
    
    func testGuessRight(){
        let wasGuessRight = Utils.wasGuessRight(aStr: "Parachute", bStr: "Parachutdd")
        XCTAssertEqual(wasGuessRight, true)
    }
    
    func testGuessWrong(){
        let wasGuessRight = Utils.wasGuessRight(aStr: "Cat", bStr: "freqfqrfreq")
        XCTAssertEqual(wasGuessRight, false)
    }
    
    
}
