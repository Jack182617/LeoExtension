//
//  Dictionary+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}
