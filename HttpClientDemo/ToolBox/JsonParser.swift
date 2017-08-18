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
        // Get the file path.
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            let error = NSError(
                domain: "[JsonParser| parseFile]",
                code: 99902,
                userInfo: ["description": "Cannot find the json file."]
            )
            completion(.error(error))
            return
        }
        
        // Create an json data.
        guard let jsonData = try? NSData(contentsOfFile: path, options: .mappedIfSafe) else {
            let error = NSError(
                domain: "[JsonParser| parseFile]",
                code: 99902,
                userInfo: ["description": "Cannot open the json file."]
            )
            completion(.error(error))
            return
        }
        
        // Parsing json from the json data.
        guard let jsonObject = try? JSONSerialization.jsonObject(
            with: jsonData as Data,
            options: .allowFragments) as? [String:Any] else {
                let error = NSError(
                    domain: "[JsonParser| parseFile]",
                    code: 99902,
                    userInfo: ["description": "Cannot parse the json data as an JsonObject."]
                )
                completion(.error(error))
                return
        }
        
        // Convert the jsonObject to Json object.
        guard let parsedObject = jsonObject, let json = Json(json: parsedObject) else {
            let error = NSError(
                domain: "[AFHttpClient| parseFile]",
                code: 99902,
                userInfo: ["description": "Cannot convert the jsonObject to an Json object."]
            )
            completion(.error(error))
            return
        }
        
        completion(.success(json))
    }
}
