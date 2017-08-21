//
//  HttpClient.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire

class HttpClient : NetworkRequest {
    static let shared = HttpClient()
    
    private var uRLSession = URLSession.shared
    
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
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            if let headers = headers {
                for (key, value) in headers {
                    request.addValue(value, forHTTPHeaderField: key)
                }
            }
            
            if let parameters = parameters {
                do {
                    let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    request.httpBody = data
                } catch {
                    completion(.error(ErrorType.PARSE_JSON_FAIL("HttpClient").error))
                    return
                }
            }
            
            self.uRLSession.dataTask(with: request) { (data, response, error) in
                do {
                    guard let data = data else {
                        throw ErrorType.RESPONSE_DATA_ERROR("HttpClient").error
                    }
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        throw ErrorType.PARSE_JSON_FAIL("HttpClient").error
                    }
                    
                    completion(.success(json))
                    
                } catch let error {
                    // Error Handling
                    // Notify client app the log out process failed
                    completion(.error(error))
                }
            }.resume()
    }
}
