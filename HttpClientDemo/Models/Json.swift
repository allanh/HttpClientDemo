//
//  Json.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

typealias JsonObject = [String: Any]

/// JSON response which can be an array of objects or a simple one.
///
/// - object: A json object.
/// - array: An array of objects.
enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])
    
    init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }
        
        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }
        
        return nil
    }
}
