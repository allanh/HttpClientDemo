//
//  NetworkRequestTests.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import XCTest
import Alamofire
import ObjectMapper
@testable import HttpClientDemo

class NetworkRequestTests: XCTestCase {
    
    // MARK: - Mocks
    
    class MockHttpClient : NetworkRequest {
        var response: Any?
        
        func request(
            _ url: URL,
            method: HTTPMethod,
            parameters: [String: Any]?,
            encoding: ParameterEncoding,
            headers: [String: String]?,
            completion: @escaping (HttpResult<Any>) -> Void)
            -> Void {
                completion(.success(response ?? ""))
        }
    }
    
    class MockModel : Mappable {
        var username: String?
        var email: String?
        var age: Int?
        
        init() { }
        
        required init?(map: Map){
            
        }
        
        func mapping(map: Map) {
            self.username   <- map["username"]
            self.email      <- map["email"]
            self.age        <- map["age"]
        }
    }
    
    // MARK: - Properties 
    
    var httpClient: NetworkRequest?
    
    let mockResponse: JsonObject = [
        "username": "Dirk",
        "email": "em@il.com",
        "age": 30
    ]
    
    // MARK: - Methods
    
    override func setUp() {
        super.setUp()
        self.httpClient = MockHttpClient()
    }
    
    override func tearDown() {
        self.httpClient = nil
        super.tearDown()
    }
    
    func testHttpClient_whenResponseTypeIsAny_veriftyFakeData() {
        // 1. Arrange
        let promise = expectation(description: "Get response success.")
        var jsonObject: Any? = nil
        
        guard let url = HttpBin.get.url else {
            XCTFail("Cannot create a URL instance.")
            return
        }
        
        // 2. Act
        self.httpClient?.response = self.mockResponse
        XCTAssertNotNil(self.httpClient?.response, "The fake data shouldn't be nil.")
        
        self.httpClient?.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, completion: { (result) in
            switch result {
            case .success(let response):
                // Success
                jsonObject = response
                promise.fulfill()
                
            case .error(let error):
                // Error Handling
                XCTFail(error.localizedDescription)
            }
        }
        )
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNotNil(jsonObject, "The jsonObject shouldn't be nil.")
        XCTAssertTrue(jsonObject is JsonObject, "The object should be JsonObject.")
    }
    
    func testHttpClient_whenResponseTypeIsJson_veriftyFakeData() {
        // 1. Arrange
        let promise = expectation(description: "Get response success.")
        var jsonObject: JsonObject? = nil
        
        guard let url = HttpBin.get.url else {
            XCTFail("Cannot create a URL instance.")
            return
        }
        
        // 2. Act
        self.httpClient?.response = self.mockResponse
        XCTAssertNotNil(self.httpClient?.response, "The fake data shouldn't be nil.")
        
        self.httpClient?.requestJson(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil,
            completion: { (result) in

            switch result {
            case .success(.object (let response)):
                // Success
                jsonObject = response
                promise.fulfill()
                
            case .error(let error):
                // Error Handling
                XCTFail(error.localizedDescription)
                
            default:
                XCTFail("Can't get a json object.")
            }
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNotNil(jsonObject, "The jsonObject shouldn't be nil.")
        XCTAssertEqual(jsonObject?.count, 3, "The count should be 3.")
        XCTAssertNotNil(jsonObject?["username"], "The jsonObject doesn't contain username key.")
        XCTAssertEqual(jsonObject?["username"] as? String, "Dirk", "The username shoudl be Dirk.")
        XCTAssertNotNil(jsonObject?["email"], "The jsonObject doesn't contain email key.")
        XCTAssertEqual(jsonObject?["email"] as? String, "em@il.com", "The age shoudl be em@il.com.")
        XCTAssertNotNil(jsonObject?["age"], "The jsonObject doesn't contain age key.")
        XCTAssertEqual(jsonObject?["age"] as? Int, 30, "The age shoudl be 30.")
    }
    
    func testHttpClient_whenResponseTypeIsMappable_veriftyFakeData() {
        // 1. Arrange
        let promise = expectation(description: "Get response success.")
        var object: MockModel? = nil
        
        guard let url = HttpBin.get.url else {
            XCTFail("Cannot create a URL instance.")
            return
        }
        
        // 2. Act
        self.httpClient?.response = self.mockResponse
        XCTAssertNotNil(self.httpClient?.response, "The fake data shouldn't be nil.")
        
        self.httpClient?.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil,
            completion: { (result: HttpResult<MockModel>) in

                switch result {
                case .success(let response):
                    // Success
                    object = response
                    promise.fulfill()
                    
                case .error(let error):
                    // Error Handling
                    XCTFail(error.localizedDescription)
                }
            }
        )
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNotNil(object, "The jsonObject shouldn't be nil.")
        XCTAssertNotNil(object?.username, "The jsonObject doesn't contain username key.")
        XCTAssertEqual(object?.username, "Dirk", "The username shoudl be Dirk.")
        XCTAssertNotNil(object?.email, "The jsonObject doesn't contain email key.")
        XCTAssertEqual(object?.email, "em@il.com", "The age shoudl be em@il.com.")
        XCTAssertNotNil(object?.age, "The jsonObject doesn't contain age key.")
        XCTAssertEqual(object?.age, 30, "The age shoudl be 30.")
    }
}
