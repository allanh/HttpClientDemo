//
//  HttpResult.swift
//  HttpClientDemo
//
//  Created by allan.shih on 2017/8/17.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

/// A generic enum that can receive any object in case of success
/// or returns a simple error.
///
/// - success: A successfull result containing a return value.
/// - error: A failure containing an error.
enum HttpResult<T> {
    case success(T)
    case error(Error)
}
