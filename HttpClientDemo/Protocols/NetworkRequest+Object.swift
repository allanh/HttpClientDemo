//
//  NetworkRequest+Object.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

extension NetworkRequest {
    
    /// Creates a request to retrieve the contents of the specified `url`,
    /// `method`, `parameters`, `encoding` and `headers`.
    ///
    /// - parameter url:        The URL.
    /// - parameter method:     The HTTP method.
    /// - parameter parameters: The parameters.
    /// - parameter encoding:   The parameter encoding.
    /// - parameter headers:    The HTTP headers.
    /// - parameter completion: The Response Handler.
    ///
    func request<T>(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<T>) -> Void)
        -> Void {
            self.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers, completion: { (result) in
                
                switch result {
                case .success(let response):
                    break
                    // We will try to parse the JsonObject as an Json object.
                    // Json object can contain an json object or json array.
//                    guard let json = Json(json: response) else {
//                        let error = NSError(
//                            domain: "[AFHttpClient| request]",
//                            code: 99902,
//                            userInfo: ["description": "Cannot parse the JsonObject as an Json object."]
//                        )
//                        completion(.error(error))
//                        return
//                    }
//                    
//                    completion(.success(json))
                    
                case .error(let error):
                    completion(.error(error))
                }
            }
        )
    }

}
