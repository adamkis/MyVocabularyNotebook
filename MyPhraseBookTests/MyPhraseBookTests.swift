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
    
    var calculator: Calculator!
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        calculator = nil
    }
    
    func testCalculatorAddEmptyInput(){
        let calcOutput = calculator.add(input: "")
        XCTAssertEqual(calcOutput, 0)
    }
    
    func testCalculatorAddOneNumber(){
        let calcOutput = calculator.add(input: "2")
        XCTAssertEqual(2,calcOutput)
    }
    
    func testCalculatorAddTwoNumbers(){
        let calcOutput = calculator.add(input: "4,8")
        XCTAssertEqual(12,calcOutput)
    }
    
    
    func testCalculatorAddTooManyNumbers(){
        let calcOutput = calculator.add(input: "4,6,77")
        XCTAssertEqual(87,calcOutput)
    }
    
    
    
    
//    func testCalculatorFalseInput(){
//        let calcOutput = calculator.add(input: "refhuer")
//        XCTAssertNil(calcOutput)
//    }
    
//    func testInitialAssert2() {
//        XCTAssertTrue(true)
//    }
//    func testEqualAssert2(){
//        XCTAssertEqual(2,2)
//    }
    
    
//    func testInitialAssert() {
//        XCTAssertTrue(false)
//    }
//    func testEqualAssert1(){
//        XCTAssertEqual(1,2)
//    }
    
}
