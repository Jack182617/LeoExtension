//
//  Config.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation
import UIKit

// MARK:- url地址
//服务器基本地址
let kBaseUrl = ""

//h5默认界面
let kh5Url = ""

// MARK:- 偏好设置
let kUserDefaults = UserDefaults.standard

// MARK:- log打印
let isDebug = false
func FMLog(log:String) {
    if isDebug == true {
        print(log)
    }
}

// MARK:- 屏幕尺寸适配
//根据设计图计算在手机上的真实尺寸(以6来作为标准：375 * 667)
func scaleFromiPhone6DesinWidth(x : CGFloat) -> CGFloat{
    return (x * (kScreenWidth / 375.0))
}

func scaleFromiPhone6DesinHeight(y : CGFloat) -> CGFloat{
    return (y * (kScreenHeight / 667.0))
}


// MARK:- 相关尺寸
//屏幕宽高
let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.width
let kScreenHeight = kScreenBounds.height

//适配iOS11
let IS_IPHONE = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone
let IS_IPHONE5 = (IS_IPHONE && UIScreen.main.bounds.size.height == 568.0)
let IS_IPHONEX = (IS_IPHONE && UIScreen.main.bounds.size.height == 812.0)

//状态栏，底部tabbar,导航栏，iPhone X底部预留高度，tabbar
let kStatusBarHeight = IS_IPHONEX ? CGFloat(44) : CGFloat(20)
let kTabBarHeight = IS_IPHONEX ? CGFloat(83) : CGFloat(49)
let kNavHeight = IS_IPHONEX ? CGFloat(88) : CGFloat(64)
let kIphoneXBottomPadding = IS_IPHONEX ? CGFloat(34) : CGFloat(0)
let kSegmentBarHeight = CGFloat(44)

let kBasePadding = scaleFromiPhone6DesinWidth(x: 16)

//轮播图控件高度
//let kCircleViewHeight = kScreenWidth * 9.0 / 16.0
let kCircleViewHeight = (200 * (kScreenWidth / 375.0))


// MARK:- 相关字体
/** 适配字体大小*/
func kFontSize(_ size:CGFloat) -> CGFloat{ // 根据不同屏幕改变字体大小
    if (kScreenWidth == 320) {
        return size - 2.0;
    }else if (kScreenWidth == 375){
        return size;
    }else{
        return size + 1.0;
    }
}
func kFontWithSize(_ size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: kFontSize(size))
}

let kMostFont = kFontWithSize(18)
let kBigFont = kFontWithSize(16)
let kBaseFont = kFontWithSize(14)
let kSmallFont = kFontWithSize(12)
let kMinFont = kFontWithSize(10)


// MARK:- 相关颜色
//白色
let kWhiteColor = UIColor.white
//黑色
let kBlackColor = UIColor.black
//红色
let kRedColor = UIColor.red

//导航栏背景色
let kNavBgColor = UIColor.white
//不可用颜色
let kDisableColor = UIColor.lightGray

//列表背景灰色
//let kTableViewBgColor = UIColor.init(hex: 0xf0f0f0)


// MARK:- xib尺寸适配
let iphone5  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:960,height:1336), (UIScreen.main.currentMode?.size)!) : false
let iphone6  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:750,height:1334), (UIScreen.main.currentMode?.size)!) : false
let iphone6p  = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1242,height:2208), (UIScreen.main.currentMode?.size)!) : false
let iphone6pBigMode = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2001), (UIScreen.main.currentMode?.size)!) : false
let iphoneXX = UIScreen.instancesRespond(to:#selector(getter: UIScreen.main.currentMode)) ? __CGSizeEqualToSize(CGSize(width:1125,height:2436), (UIScreen.main.currentMode?.size)!) : false

//适配参数
let suitParm:CGFloat = (iphone6p ? 1.12 : (iphone6 ? 1.0 : (iphone6pBigMode ? 1.01 : (iphoneXX ? 1.0 : 0.85))))



