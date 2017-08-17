//
//  HttpBinResponse.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import ObjectMapper

class Args {

}

class HttpBinResponse: Mappable {
	var args : Args?
	var headers : Headers?
	var origin : String?
	var url : String?
    
    init() { }

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.args       <- map["args"]
        self.headers    <- map["headers"]
        self.origin     <- map["origin"]
        self.url        <- map["url"]
    }
}
