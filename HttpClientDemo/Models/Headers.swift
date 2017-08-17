//
//  Headers.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation
import ObjectMapper

class Headers: Mappable {
	var accept : String?
	var acceptEncoding : String?
	var acceptLanguage : String?
	var connection : String?
	var cookie : String?
	var host : String?
	var referer : String?
	var upgradeInsecureRequests : Int?
	var userAgent : String?
    
    init() { }
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        self.accept <- map["Accept"]
        self.acceptEncoding <- map["Accept-Encoding"]
        self.acceptLanguage <- map["Accept-Language"]
        self.connection <- map["Connection"]
        self.cookie <- map["Cookie"]
        self.host                       <- map["Host"]
        self.referer                    <- map["Referer"]
        self.upgradeInsecureRequests    <- map["Upgrade-Insecure-Requests"]
        self.userAgent                  <- map["User-Agent"]
    }
}
