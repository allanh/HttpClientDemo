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
    func request<T: Mappable>(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (Result<T>) -> Void)
        -> Void {
            
            self.requestJson(url, method: method, parameters: parameters, encoding: encoding, headers: headers, completion: { (jsonResult) in
                
                switch jsonResult {
                case .success(.object (let jsonObject)):
                    // Success
                    print("[NetworkRequest] jsonObject: \(jsonObject))")
                    
                    /// Maps a JSON dictionary to an object
                    guard let parsedObject = Mapper<T>().map(JSON: jsonObject) else {
                        let error = NSError(
                            domain: "[NetworkRequest | request]",
                            code: 99904,
                            userInfo: ["description": "Conversion from JSON failed."]
                        )
                        completion(.error(error))
                        return
                    }
                    
                    completion(.success(parsedObject))
                    
                case .error(let error):
                    // Error Handling
                    completion(.error(error))
                    
                default:
                    let error = NSError(
                        domain: "[HttpBinManager | getJsonObjectFromHttBin]",
                        code: 99904,
                        userInfo: ["description": "Can't get a json object."]
                    )
                    completion(.error(error))
                }
            }
        )
    }

}
