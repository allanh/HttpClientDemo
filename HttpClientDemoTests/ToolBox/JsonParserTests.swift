//
//  JsonParserTests.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/18.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import XCTest
@testable import HttpClientDemo

class JsonParserTests: XCTestCase {
    
    var parser: JsonParser?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.parser = JsonParser()
    }
    
    override func tearDown() {
        self.parser = nil
        super.tearDown()
    }
    
    func testParseFileWhenUseJsonFileReturnJson() {
        // 1. Arrange
        let promise = expectation(description: "Parsing Json Success.")
        var jsonObject: JsonObject? = nil
        var parseError: Error? = nil
        
        // 2. Act
        self.parser?.parseFile("GetResponse", completion: { (result) in
            switch result {
            case .success(.object (let response)):
                // Success
                jsonObject = response
                promise.fulfill()
                
            case .error(let error):
                // Error Handling
                parseError = error
                XCTFail("Parsing Json Fail.")

            default:
                XCTFail("Can't get a json object.")
            }
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNil(parseError, "The parseError shouldn't be nil.")
        XCTAssertNotNil(jsonObject, "The jsonObject should be nil.")
        XCTAssertEqual(jsonObject?.count, 4, "The count should be 4.")
        XCTAssertNotNil(jsonObject?["args"], "The jsonObject doesn't contain args key.")
        XCTAssertNotNil(jsonObject?["headers"], "The jsonObject doesn't contain headers key.")
        XCTAssertNotNil(jsonObject?["origin"], "The jsonObject doesn't contain origin key.")
        XCTAssertEqual(jsonObject?["origin"] as? String, "125.227.33.50", "The origin shoudl be 125.227.33.50.")
        XCTAssertNotNil(jsonObject?["url"], "The jsonObject doesn't contain origin key.")
        XCTAssertEqual(jsonObject?["url"] as? String, "http://httpbin.org/get", "The url shoudl be http://httpbin.org/get.")
    }
    
    func testParseFileWhenNotFoundFileReturnError() {
        // 1. Arrange
        let promise = expectation(description: "Parsing Json Fail.")
        var jsonObject: JsonObject? = nil
        var parseError: Error? = nil
        
        // 2. Act
        self.parser?.parseFile("NotFoundJsonFile", completion: { (result) in
            switch result {
            case .success(.object (let response)):
                // Success
                jsonObject = response
                XCTFail("Parsing Json Success.")
                
            case .error(let error):
                // Error Handling
                parseError = error
                promise.fulfill()
                
            default:
                XCTFail("Can't get a json object.")
            }
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNil(jsonObject, "The jsonObject should be nil.")
        XCTAssertNotNil(parseError, "The parseError shouldn't be nil.")
    }
}
