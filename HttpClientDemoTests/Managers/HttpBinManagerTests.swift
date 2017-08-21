//
//  HttpBinManagerTests.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import XCTest
import Alamofire
@testable import HttpClientDemo

class HttpBinManagerTests: XCTestCase {
    
    // MARK: - Mocks
    
    class MockHttpClient : NetworkRequest {
        var response: Any?

        func request(
            _ url: URL,
            method: HTTPMethod,
            parameters: [String: Any]?,
            encoding: ParameterEncoding,
            headers: [String: String]?,
            completion: @escaping (HttpResult<Any>) -> Void) {
                completion(.success(response ?? ""))
        }
    }
    
    var httpClient: NetworkRequest?
    var manager: HttpBinManager?
    
    let mockResponse: JsonObject = [
        "username": "Rodrigo",
        "email": "em@il.com",
        "age": 29
    ]
    
    override func setUp() {
        super.setUp()
        self.httpClient = MockHttpClient()
        self.httpClient?.response = self.mockResponse

        self.manager = HttpBinManager()
        self.manager?.setHttpClient(self.httpClient ?? MockHttpClient())
    }
    
    override func tearDown() {
        self.manager = nil
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
    
    func testGetJsonObjectFromHttpBin_useFakeResponse_returnJson() {
        // 1. Arrange
        let promise = expectation(description: "Get response success.")
        var jsonObject: JsonObject? = nil
        
        // 2. Act
        self.manager?.setHttpClient(self.httpClient)
        self.manager?.getJsonObjectFromHttpBin(onSuccess: { (result) in
            jsonObject = result
            promise.fulfill()
        }, onError: { (error) in
            XCTFail(error.localizedDescription)
        })
        waitForExpectations(timeout: 2, handler: nil)
        
        // 3. Assert
        XCTAssertNotNil(jsonObject, "The jsonObject shouldn't be nil.")
        XCTAssertEqual(jsonObject?.count, 3, "The count should be 3.")
        XCTAssertNotNil(jsonObject?["username"], "The jsonObject doesn't contain username key.")
        XCTAssertEqual(jsonObject?["username"] as? String, "Rodrigo", "The username shoudl be Rodrigo.")
        XCTAssertNotNil(jsonObject?["email"], "The jsonObject doesn't contain email key.")
        XCTAssertEqual(jsonObject?["email"] as? String, "em@il.com", "The age shoudl be em@il.com.")
        XCTAssertNotNil(jsonObject?["age"], "The jsonObject doesn't contain age key.")
        XCTAssertEqual(jsonObject?["age"] as? Int, 29, "The age shoudl be 29.")
    }
}
