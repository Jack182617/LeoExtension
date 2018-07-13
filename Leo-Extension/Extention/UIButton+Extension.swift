//
//  UIButton+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation
import UIKit
extension UIButton {
    //使用convenience修饰的构造函数叫做遍历构造函数，通常用于对系统的类进行构造函数扩充时
    /*
     遍历构造函数都是写在extension，一般用convenience修饰
     必须明确的调用self.init（）
     */
    convenience init (imageName:String,bgImageName:String) {
        self.init()
        setImage(UIImage.init(named: imageName), for: .normal)
        setBackgroundImage(UIImage.init(named: bgImageName), for: .normal)
        sizeToFit()
    }
    convenience init (title:String,color:UIColor,textFont:UIFont) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(color, for: .normal)
        titleLabel?.font = textFont
        sizeToFit()
    }
    convenience init (title:String,backgroudColor:UIColor,textFont:UIFont) {
        self.init()
        setTitle(title, for: .normal)
        backgroundColor = backgroudColor
        titleLabel?.font = textFont
    }
    
    //设置按钮文字和图片的相对位置
    //左右互换位置时 left和right都得设置，因为本身中间有间隔，如果只设置left或者right，那将会在中间重合
    //上线互换位置时 只需设置top和bottom中的一个，如果同时设置了就会增加很大的间隔
    func setTextAndImagePosition(textPosition:Int,space:CGFloat) {
        self.titleLabel?.backgroundColor = self.backgroundColor
        self.imageView?.backgroundColor = self.backgroundColor
        let titleSize0 = self.titleLabel?.bounds.size
        let imageSize0 = self.imageView?.bounds.size
        
        if LEFT == textPosition{
            //文字在左，图片在右
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -((imageSize0?.width)!) - space, bottom: 0, right: (imageSize0?.width)! + space)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (titleSize0?.width)! + space, bottom: 0, right: -(titleSize0?.width)! - space)
        }else if TOP == textPosition{
            //文字在上切居中显示
            self.titleEdgeInsets = UIEdgeInsets.init(top: -((imageSize0?.height)!) - space, left: -((imageSize0?.width)!), bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets.init(top: (titleSize0?.height)! + space, left: (titleSize0?.width)!, bottom: 0, right: 0)
        }else if BOTTOM == textPosition{
            //文字在下切居中显示
            self.titleEdgeInsets = UIEdgeInsets.init(top: ((imageSize0?.height)!), left: -((imageSize0?.width)!), bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets.init(top: -(titleSize0?.height)!, left: (titleSize0?.width)!, bottom: 0, right: 0)
        }else if CENTER == textPosition{
            //文字和图片在中间重叠
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -((imageSize0?.width)!), bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: (titleSize0?.width)!, bottom: 0, right: 0)
        }
    }
}
