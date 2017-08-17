//
//  HttpBinManager.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire

/// Represents the url of HttpBin service.
enum HttpBin : Int {
    case get, post, put, delete
    
    private var host: URL? {
      return URL(string: "https://httpbin.org")
    }
    
    var url: URL? {
        switch self {
        case .get:
            return host?.appendingPathComponent("/get")
            
        case .post:
            return host?.appendingPathComponent("/post")
            
        case .put:
            return host?.appendingPathComponent("/put")
            
        case .delete:
            return host?.appendingPathComponent("/delete")
        }
    }
}

class HttpBinManager {
    static let shared = HttpBinManager()
    
    private var httpClient: NetworkRequest = AFHttpClient.shared
    private let headers: HTTPHeaders = [
        "APIKey": "API_KEY",
        "Accept": "application/json"
    ]
    
    /// Get an Json Object from HttpBin server.
    ///
    /// - Parameters:
    ///   - onSuccess: onSuccess closure
    ///   - onError: return Error
    public func getJsonObjectFromHttpBin(onSuccess:@escaping (JsonObject?)->(),
                        onError:@escaping(_ error:Error)->()) {
        
        // Setup 'url'
        guard let url = HttpBin.get.url else {
            let error = NSError(
                domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                code: 99903,
                userInfo: ["description": "Unable Create End Point."]
            )
            onError(error)
            return
        }
        
        // Send Request
        self.httpClient.requestJson(
            url,
            method: .get,
            parameters: nil,
            encoding: URLEncoding.default,
            headers: self.headers,
            completion: { (result) in
                
                switch result {
                case .success(.object (let response)):
                    // Success
                    print("[HttpBinManager] respone: \(response)")
                    onSuccess(response)
                    
                case .error(let error):
                    // Error Handling
                    onError(error)
                    
                default:
                    let error = NSError(
                        domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                        code: 99904,
                        userInfo: ["description": "Unable Create End Point."]
                    )
                    onError(error)
                }
            }
        )
    }
    
    /// Set the Http Client.
    ///
    /// - Parameter networkRequest: A NetworkRequest instance
    internal func setHttpClient(_ networkRequest: NetworkRequest) {
        self.httpClient = networkRequest
    }
}
