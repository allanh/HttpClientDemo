//
//  AFHttpClient.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire

class AFHttpClient : NetworkRequest {
    static let shared = AFHttpClient()
    
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
    func request(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (HttpResult<Any>) -> Void)
        -> Void {
            
            Alamofire.request(
                url,
                method: method,
                parameters: parameters,
                encoding: encoding,
                headers: headers)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    print("[AFHttpClient] response: \(response.result.debugDescription)")
                    
                    switch response.result {
                    case .success:
                        guard let value = response.result.value else {
                            let error = NSError(
                                domain: "[AFHttpClient| request]",
                                code: 99901,
                                userInfo: ["description": "Cannot get the result."]
                            )
                            completion(.error(error))
                            return
                        }

                        completion(.success(value))

                    case .failure(let error):
                        // Error Handling
                        print(error.localizedDescription)
                        completion(.error(error))
                    }
            })
    }
}
