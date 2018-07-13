//
//  String+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /*
     *去掉首尾空格
     */
    var removeHeadAndTailSpace:String {
        let whitespace = NSCharacterSet.whitespaces
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉首尾空格 包括后面的换行 \n
     */
    var removeHeadAndTailSpacePro:String {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        return self.trimmingCharacters(in: whitespace)
    }
    /*
     *去掉所有空格
     */
    var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
    /*
     *去掉首尾空格 后 指定开头空格数
     */
    func beginSpaceNum(num: Int) -> String {
        var beginSpace = ""
        for _ in 0..<num {
            beginSpace += " "
        }
        return beginSpace + self.removeHeadAndTailSpacePro
    }
    
//    var md5 : String{
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
//        
//        CC_MD5(str!, strLen, result)
//        
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        result.deinitialize()
//        
//        return String(format: hash as String)
//    }
    
    //判断是否满足传入的正则表达式
    func fulfilRegularExpression(regex:String) -> Bool {
        var result = false
        let test = NSPredicate(format: "SELF MATCHES %@" , regex)
        
        result = (test.evaluate(with: self))
        
        return result;
    }
    
    //判断是否是URL地址
    func isURL() -> Bool {
        
        var result1 = false
        var result2 = false
        
        let urlRegex1 = "^https://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
        let urlTest1 = NSPredicate(format: "SELF MATCHES %@" , urlRegex1)
        
        result1 = (urlTest1.evaluate(with: self))
        
        let urlRegex2 = "^http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
        let urlTest2 = NSPredicate(format: "SELF MATCHES %@" , urlRegex2)
        
        result2 = (urlTest2.evaluate(with: self))
        
        return result1 || result2
    }
    
    //验证电话号码
    func isPhoneNumber() -> Bool {
        
        var result = false
        
        let phoneRegex = "^((13[0-9])|(17[0-9])|(14[^4,\\D])|(15[^4,\\D])|(18[0-9]))\\d{8}$|^1(7[0-9])\\d{8}$";
        let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)
        
        result = (phoneTest.evaluate(with: self))
        
        return result;
    }
    
    
    //验证邮箱格式
    func isZipCodeNumber() -> Bool {
        if self.count == 0 {
            return false
        }
        let zipCodeNumber = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let regexCodeNumber = NSPredicate(format: "SELF MATCHES %@",zipCodeNumber)
        if regexCodeNumber.evaluate(with: self) == true {
            return true
        }else
        {
            return false
        }
    }
    
    //判断是否是身份证号
    func isUserIdCard() -> Bool {
        let pattern = "(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
        let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch:Bool = pred.evaluate(with: self)
        return isMatch;
    }
    
    //判断是否是纯数字
    func validateNumber() -> Bool {
        let nsStr = NSString(string: self)
        var res = true
        let temSet = NSCharacterSet(charactersIn: "0123456789")
        var i = 0
        while i < nsStr.length {
            let str:NSString = nsStr.substring(with: NSMakeRange(i, 1)) as NSString
            let range:NSRange = str.rangeOfCharacter(from: temSet as CharacterSet)
            if range.length == 0 {
                res = false
                break
            }
            i = i+1
            
        }
        return res
        
    }
    
    
    
    //判断是否是纯字母
    //只能输入字母
    func validateLetter() -> Bool {
        let nsStr = NSString(string: self)
        var res = true
        let tmSet = NSCharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXWZ")
        var i = 0
        while i < nsStr.length {
            let string1:NSString = (nsStr as NSString).substring(with: NSMakeRange(i, 1)) as NSString
            let range = string1.rangeOfCharacter(from: tmSet as CharacterSet)
            if (range.length == 0) {
                res = false
                break;
            }
            i = i+1
        }
        return res
    }
    
    /**
     判断是否包含该中文
     */
    func containChinese(str:NSString) -> Bool{
        for i in 0 ..< str.length {
            let a = str.character(at: i)
            if a > 0x4e00 && a < 0x9fff {
                return true
            }
        }
        return false
    }
    
    // String转float
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    
    var intValue: Int {
        return (self as NSString).integerValue
    }
    
    //保留两位小数
    func remainTwoDecimal() -> String {
        return String(format: "%.2f", floatValue)
    }
    
    // 过滤掉所有换行、空格和Tab
    func removeAllSpaceAndNewline() -> String {
        
        var str = self.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: " ", with: "")
        str = str.replacingOccurrences(of: "\r", with: "")
        str = str.replacingOccurrences(of: "\n", with: "")
        return str
    }
    
    //把图片地址的空格替换为 20%
    func replaceSpaceWith20Percent() -> String {
        var str = self.replacingOccurrences(of: " ", with: "%20")
        str = str.replacingOccurrences(of: " ", with: "%20")
        return str
    }
    
    /**
     时间戳转时间
     */
    
    func formartTimeStamp() -> String {
        let string = NSString.init(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }
    
    func formatTimeWithRex(rex:String) -> String {
        let string = NSString.init(string: self)
        let timeSta:TimeInterval = string.doubleValue
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = rex
        let date = Date.init(timeIntervalSince1970: timeSta)
        return timeFormatter.string(from: date)
    }
    
    //根据时间格式把当前时间戳转为时间
    func getCurrentTime() -> String {
        let date = Date()
        let timeFormatter = DateFormatter()
        //        timeFormatter.dateFormat = "yyy-MM-dd 'at' HH:mm:ss.SSS"
        timeFormatter.dateFormat = self
        let strNowTime = timeFormatter.string(from: date) as String
        //        print("系统当前时间：\(strNowTime)")
        //        print("系统当前时间戳：\(date.timeIntervalSince1970)")
        return strNowTime
    }
    
    
    /**将分变成元*/
    func yuanMoneyString() -> String {
        let string = NSString.init(string: self)
        var newString = String(string)
        if string.length>2 {
            newString = string.substring(to: string.length-2) + "." + string.substring(with: NSRange.init(location: string.length-2, length: 2))
        } else if string.length == 2 {
            newString = "0." + String(string )
            
        } else if string.length == 1{
            newString = "0.0" + String(string )
        } else {
            newString = "0.00"
        }
        return newString
    }
    /**
     将字典数组变成json 字符串
     */
    func changeDictionsToJsonString(dics:Any) -> String {
        var dataStr = ""
        do{
            let data = try JSONSerialization.data(withJSONObject: dics, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            dataStr  = String(describing: NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)!)
        }catch{
            FMLog(log: "转换失败：\(error)")
        }
        return dataStr
    }
    /**
     将json字符串转dic
     */
    func getJsonDic() -> Any? {
        var dic : Any!
        let jsonData = self.data(using: String.Encoding.utf8)
        if nil != jsonData {
            do {
                dic = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)
            } catch {
                FMLog(log: "解析错误")
            }
        }
        
        return dic
    }
    /**
     根据字体和宽度计算文字高度
     
     - parameter width: 约束宽度
     - parameter font:  字体大小
     
     - returns: 高度
     */
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.height
    }
    
    /**
     根据字体和宽度计算文字宽度
     
     - parameter width: 约束宽度
     - parameter font:  字体大小
     
     - returns: 宽度
     */
    func widthWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
    
    //分转元（后台获取的金钱一律都是分为单位）
    func transformFenToYuan() -> String{
        return String(self.doubleValue / 100.00).remainTwoDecimal()
    }
    
    //打电话
    //
    func callPhone() {
        let urlString = "tel://" + self
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    //截取字符串
    func subStrToIndex(index: Int) -> String {
        return (self as NSString).substring(to: index)
    }
    
    
}
