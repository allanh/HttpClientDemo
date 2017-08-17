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
            completion: @escaping (HttpResult<Any>) -> Void)
            -> Void {
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
}
