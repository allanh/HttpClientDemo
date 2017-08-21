//
//  Collection+safe.swift
//  Aristotle_DTW
//
//  Created by allan.shih on 2017/3/29.
//  Copyright © 2017年 sue.liu. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
