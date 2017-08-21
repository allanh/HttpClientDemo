//
//  NetworkRequest.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol Parseable {
    func parseJson(_ response: Any) throws -> Json
}

protocol NetworkRequest: Parseable {
    var response: Any? { get set }

    /// Creates a request to retrieve the contents of the specified `url`,
    /// `method`, `parameters`, `encoding` and `headers`.
    ///
    /// - parameter url:        The URL.
    /// - parameter method:     The HTTP method.
    /// - parameter parameters: The parameters.
    /// - parameter encoding:   The parameter encoding.
    /// - parameter headers:    The HTTP headers.
    /// - parameter completion:  The Response Handler.
    ///
    func request(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (HttpResult<Any>) -> Void)
        -> Void
    
    func request<T: Mappable>(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (HttpResult<T>) -> Void)
        -> Void
    
    func requestJson(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        headers: [String: String]?,
        completion: @escaping (HttpResult<Json>) -> Void)
        -> Void
}

// MARK: - Property default value

extension NetworkRequest {
    var response: Any? {
        get {
            return nil
        }
        set {
            
        }
    }
}
