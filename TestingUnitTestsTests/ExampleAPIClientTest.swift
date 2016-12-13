//
//  ExampleAPIClientTest.swift
//  TestingUnitTests
//
//  Created by Ievgen Keba on 12/12/16.
//  Copyright © 2016 Harman Inc. All rights reserved.
//

import XCTest

@testable import TestingUnitTests

class ExampleAPIClientTest: XCTestCase {
    
    var sun: ExampleAPIClient!
    var completionInvoked = false
    
    override func setUp() {
        super.setUp()
        sun = ExampleAPIClient()
    }
    
    override func tearDown() {
        sun = nil
        super.tearDown()
    }
    
    func testParseServerDataDoesntCallCompletionWithBrokenJSON() {
        let brokenJsonData = "{".data(using: String.Encoding.utf8)
        sun.completion = fakeCompletion
        
        sun.parseServerData(brokenJsonData, response: nil, error: nil)
        
        XCTAssertFalse(completionInvoked, "Completion closure must not be called with broken JSON data.")
    }
    
    func testParseServerDataCallsCompletionWithProperJSON() {
        let goodJsonData = " {\"name\": \"Juanita Banana\"} ".data(using: String.Encoding.utf8)
        sun.completion = fakeCompletion
        
        sun.parseServerData(goodJsonData, response: nil, error: nil)
        
        XCTAssertTrue(completionInvoked, "Completion closure must be called with proper JSON data.")
    }
    
    func testParseServerDataExitsIfCalledWithError() {
        let error = NSError(domain: "Test", code: 0, userInfo: nil)
        let brokenJsonData = "{".data(using: String.Encoding.utf8)
        let mockedSut = MockExampleAPIClient()
        
        mockedSut.parseServerData(brokenJsonData, response: nil, error: error)
        
        XCTAssertFalse(mockedSut.parseJSONDataInvoked, "JSON parser shouldn't be invoked if method is invoked with error.")
    }
    
    func testParseServerDataExitsIfCalledWithoutData() {
        let mockedSut = MockExampleAPIClient()
        
        mockedSut.parseServerData(nil, response: nil, error: nil)
        
        XCTAssertFalse(mockedSut.parseJSONDataInvoked, "JSON parser shouldn't be invoked if method is invoked with error.")
    }
    
    func testFetchExample () {
        
        let expect = expectation(description: "longRunning")
        let mokedSun = MockExampleClosure()
        
        mokedSun.fetchExample { (dictionary) in
            XCTAssertTrue(mokedSun.testClosure, "fkkk")
            expect.fulfill()
        }
        waitForExpectations(timeout: (5)) {
            error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    // MARK: - Fake escape Closure
    func fakeCompletion(_ jsonData: Dictionary<String, AnyObject>) -> Void {
        completionInvoked = true
    }
}
// MARK: - Mock class
class MockExampleAPIClient: ExampleAPIClient {
    var parseJSONDataInvoked = false
    
    override func parseJSONData(_ data: Data, options opt: JSONSerialization.ReadingOptions) throws -> Any {
        parseJSONDataInvoked = true
        return []
    }
}

class MockExampleClosure: ExampleAPIClient {
    
    var testClosure = false
    
    override func parseServerData(_ data: Data?, response: URLResponse?, error: Error?) {
        testClosure = true
        completion?(Dictionary())
    }
}

