//
//  NSLayoutConstraint+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

//xib屏幕尺寸适配

import Foundation
import UIKit

extension NSLayoutConstraint{
    @IBInspectable var adapterScreen:Bool{
        get {
            return true
        }
        
        set {
            if newValue {
                self.constant = self.constant * suitParm
            }
        }
        
    }
}
