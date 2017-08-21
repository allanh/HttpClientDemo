//
//  JsonParser.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/18.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

class JsonParser {
    static let shared = JsonParser()

    func parseFile(_ fileName: String, completion: @escaping (HttpResult<Json>) -> Void) {
        do {
            
            guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
                throw ErrorType.INVALID_PATH("JsonParser").error
            }
        
            guard let jsonData = try? NSData(contentsOfFile: path, options: .mappedIfSafe) else {
                throw ErrorType.RESPONSE_DATA_ERROR("JsonParser").error
            }
        
            guard let jsonObject = try? JSONSerialization.jsonObject(
                with: jsonData as Data,
                options: .allowFragments) as? [String:Any] else {
                    throw ErrorType.PARSE_JSON_FAIL("JsonParser").error
            }
        
            // Convert the jsonObject to Json object.
            guard let parsedObject = jsonObject, let json = Json(json: parsedObject) else {
                throw ErrorType.CONVERT_JSON_TO_OBJECT_FAIL("JsonParser").error
            }
        
            completion(.success(json))
            
        } catch let error {
            // Error Handling
            completion(.error(error))
        }
    }
}
