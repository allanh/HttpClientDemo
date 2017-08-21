//
//   ErrorCode.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/21.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

enum ErrorType {
    case PARSE_JSON_FAIL(String)
    case UNABLE_TO_CREATE_END_POINT(String)
    case UNKNOWN_ERROR(String)
    case CONVERT_JSON_TO_OBJECT_FAIL(String)
    case MISSING_PARAMETER(String)
    case RESPONSE_DATA_ERROR(String)
    case INVALID_PATH(String)
    
    var description: String {
        return "description"
    }
    
    var code: Int {
        switch self {
        case .UNABLE_TO_CREATE_END_POINT(_):    return 99901
        case .PARSE_JSON_FAIL(_):               return 99902
        case .CONVERT_JSON_TO_OBJECT_FAIL(_):   return 99903
        case .RESPONSE_DATA_ERROR(_):           return 99904
        case .MISSING_PARAMETER(_):             return 99905
        case .INVALID_PATH(_):                  return 99906
        case .UNKNOWN_ERROR(_):                 return 99909
        }
    }
    
    var error: Error {
        switch self {
        case .UNABLE_TO_CREATE_END_POINT(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Can't get a json object."]
            )
        
        case .PARSE_JSON_FAIL(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Cannot parse the response as an Json object."]
            )
            
        case .CONVERT_JSON_TO_OBJECT_FAIL(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Conversion from JSON failed."]
            )
            
        case .RESPONSE_DATA_ERROR(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "No Data."]
            )
          
        case .MISSING_PARAMETER(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Missing some parameter."]
            )
            
        case .INVALID_PATH(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Invalid Path."]
            )
                        
        case .UNKNOWN_ERROR(let domain):
            return NSError(
                domain: domain,
                code: self.code,
                userInfo: [self.description: "Unknow error occured."]
            )
            
        }
    }
}
