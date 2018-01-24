//
//  Collection+safeTests.swift
//  Aristotle
//
//  Created by allan.shih on 2017/5/23.
//  Copyright © 2017年 Fuhu Inc. All rights reserved.
//

import XCTest
@testable import HttpClientDemo

class Collection_safeTests: XCTestCase {

    // MARK: - Mocks
    
    let testArry = ["0", "1", "2", "3", "4"]
    let array = [1, 3, 4, 6 ,7 ,8 ,9]

    // MARK: - Setup and tearDown
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testCollectionSafeIndex_whenIndexIs4_refurnElement() {
        // 1. Arrange
        var test = -1
        
        // 2. Act
        test = array[safe: 4] ?? -1
        
        // 3. Assert
        XCTAssertEqual(test, 7, "Test should be 7.")
    }
    
    func testCollectionSafeIndex_whenIndexIs7_refurnElement() {
        // 1. Arrange
        var test: Int? = nil
        
        // 2. Act
        test = array[safe: 77]
        
        // 3. Assert
        XCTAssertNil(test, "Test should be nil.")
    }
    
    func testCollectionSafeIndex_useASpecifiedIndex_refurnElement() {
        // 1. Arrange
        let testElement: String?
        
        // 2. Act
        testElement = testArry[safe: 1]
        
        
        // 3. Assert
        XCTAssertNotNil(testElement)
        XCTAssertEqual(testElement, "1", "The element should be 1")
    }
    
    func testCollectionSafeIndex_useOutOfBoundIndex_refurnNil() {
        // 1. Arrange
        let testElement: String?
        
        // 2. Act
        testElement = testArry[safe: 5]
        
        
        // 3. Assert
        XCTAssertNil(testElement, "The element should be nil")
    }
    
    func testCollectionSafeIndex_useNegativeNumber_refurnNil() {
        // 1. Arrange
        let testElement: String?
        
        // 2. Act
        testElement = testArry[safe: -1]
        
        
        // 3. Assert
        XCTAssertNil(testElement, "The element should be nil")
    }
}
