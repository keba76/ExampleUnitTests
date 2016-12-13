//
//  ExampleTest.swift
//  TestingUnitTests
//
//  Created by Ievgen Keba on 12/12/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import XCTest
@testable import TestingUnitTests

class ExampleTest: XCTestCase {
    
    var sun: Example!
    
    static let mainName = "Juanita Banana"
    static let mainDestructivePower = 4
    static let mainMotivation = 2
    static let mainRating = 3
    
    let jsonData: Dictionary<String, AnyObject> = [ Example.dictionaryKeyName: "Juanita Banana" as AnyObject,
                                                    Example.dictionaryKeyDestructivePower: 4 as AnyObject,
                                                    Example.dictionaryKeyMotivation: 2 as AnyObject ]
    
    override func setUp() {
        super.setUp()
        sun = Example(dictionary: jsonData)
    }
    
    override func tearDown() {
        sun = nil
        super.tearDown()
    }
    func testExampleWrongData () {
        for x in 1...4 {
            XCTAssertNotNil(Example(dictionary: [Example.dictionaryKeyName: "Juanita Banana" as AnyObject, Example.dictionaryKeyDestructivePower: x as AnyObject, Example.dictionaryKeyMotivation: x as AnyObject]), "Properties desructivePower and motivation must be in rage 1...4")
        }
   }
    
    func testExampleEmptyKeyMotivation () {
        
        XCTAssertNil(Example(dictionary: [Example.dictionaryKeyName: "Juanita Banana" as AnyObject, Example.dictionaryKeyMotivation: 2 as AnyObject ]), "No property must be returned from an empty motivation")
    }
    
    func testExampleEmptyKeyDestructive() {
        
        XCTAssertNil(Example(dictionary: [Example.dictionaryKeyName: "Juanita Banana" as AnyObject, Example.dictionaryKeyDestructivePower: 4 as AnyObject ]), "No property must be returned from an empty destructive")
    }
    
    func testExampleInitialicedFromEmptyDict() {
        
        XCTAssertNil(Example(dictionary: Dictionary()), "No object must be returned from an empty dictionary.")
    }
    
    func testExampleIniticedFromProperDict () {
        
        XCTAssertNotNil(sun, "An EvilDude object must be returned from a dictionary with proper data.")
    }
    
    func testExampleNameAssignement () {
        
        XCTAssertEqual(sun.name, ExampleTest.mainName, "Name should be assigned to the value in the dictionary.")
    }
    
    func testExampleDestructivePowerAssignement () {
        
        XCTAssertEqual(sun.destructivePower, ExampleTest.mainDestructivePower, "Destructive power should be assigned to the value in the dictionary.")
    }
    
    func testExampleMotivationAssignement () {
        
        XCTAssertEqual(sun.motivation, ExampleTest.mainMotivation, "Motivation should be assigned to the value in the dictionary.")
    }
    
    func testExampleRatingComputation () {
        
        XCTAssertEqual(sun.rating, ExampleTest.mainRating, "Rating should be computed with the destructive power and the motivation.")
    }
}
