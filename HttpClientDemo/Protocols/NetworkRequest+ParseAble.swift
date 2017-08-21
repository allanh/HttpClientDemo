//
//  NetworkRequest+ParseAble.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/21.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

// MARK: - Parseable

extension NetworkRequest {
    func parseJson(_ response: Any) throws -> Json {
        guard let json = Json(json: response) else {
            throw ErrorType.PARSE_JSON_FAIL("AFHttpClient").error
        }
        
        return json
    }
}
