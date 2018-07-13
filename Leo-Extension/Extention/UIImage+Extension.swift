//
//  UIImage+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation
import UIKit

public enum ImageCompressType {
    case Session
    case Timeline
}

extension UIImage {
    
    //二分压缩法
    func compressImageMid(maxLength: Int) -> UIImage? {
        var compression: CGFloat = 1
        //        guard var data = UIImagePNGRepresentation(self)! else { return nil }
        var data = UIImagePNGRepresentation(self)
        FMLog(log: "压缩前kb: \( Double((data?.count)!/1024))")
        if (data?.count)! < maxLength {
            //            return data
            return UIImage.init(data: data!)
        }
        //        print("压缩前kb", (data?.count)! / 1024, "KB")
        var max: CGFloat = 1
        var min: CGFloat = 0
        for _ in 0..<6 {
            compression = (max + min) / 2
            data = UIImageJPEGRepresentation(self, compression)!
            if CGFloat((data?.count)!) < CGFloat(maxLength) * 0.9 {
                min = compression
            } else if (data?.count)! > maxLength {
                max = compression
            } else {
                break
            }
        }
        //        var resultImage: UIImage = UIImage(data: data)!
        if (data?.count)! < maxLength {
            //            return data
            return UIImage.init(data: data!)
        }
        
        //        return data
        return UIImage.init(data: data!)
    }
    
    
    func wxCompress(type: ImageCompressType = .Session) -> UIImage {
        
        let size = self.wxImageSize(type: type)
        let reImage = resizedImage(size: size)
        let data = UIImageJPEGRepresentation(reImage, 0.1)!
        
        return UIImage.init(data: data)!
        
    }
    
    func wxImageSize(type: ImageCompressType) -> CGSize {
        var width = self.size.width
        var height = self.size.height
        
        var boundary: CGFloat = 1280
        
        if width < boundary && height < boundary {
            return CGSize(width: width, height: height)
        }
        
        let s = max(width, height) / min(width, height)
        if s <= 2 {
            // Set the larger value to the boundary, the smaller the value of the compression
            let x = max(width, height) / boundary
            if width > height {
                width = boundary
                height = height / x
            } else {
                height = boundary
                width = width / x
            }
        } else {
            // width, height > 1280
            if min(width, height) >= boundary {
                boundary = type == .Session ? 800 : 1280
                // Set the smaller value to the boundary, and the larger value is compressed
                let x = min(width, height) / boundary
                if width < height {
                    width = boundary
                    height = height / x
                } else {
                    height = boundary
                    width = width / x
                }
            }
        }
        return CGSize(width: width, height: height)
        
    }
    
    func resizedImage(size: CGSize) -> UIImage {
        var newSize = CGSize(width: self.size.width, height: self.size.height)
        let tempHeight = newSize.height / size.height
        let tempWidth = newSize.width / size.width
        
        if tempWidth > 1.0 && tempWidth > tempHeight {
            newSize = CGSize(width: self.size.width / tempWidth, height: self.size.height / tempWidth)
        } else if tempHeight > 1.0 && tempWidth < tempHeight {
            newSize = CGSize(width: self.size.width / tempHeight, height: self.size.height / tempHeight)
        }
        
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
        
    }
    
    static func compressImage(sourceImage: UIImage, targetWidth: CGFloat) -> UIImage {
        let imageSize = sourceImage.size
        
        let width = imageSize.width
        let height = imageSize.height
        
        let targetHeight = (targetWidth / width) * height
        UIGraphicsBeginImageContext(CGSize(width: targetWidth, height: targetHeight))
        
        //        sourceImage.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        sourceImage.draw(in: CGRect(x: 0, y: 0, width: targetWidth, height: targetHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func getPixelColor(pos:CGPoint) -> UIColor {
        let pixelData = self.cgImage!.dataProvider!.data
        let data = CFDataGetBytePtr(pixelData)
        let pixelInfo = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let red = CGFloat((data?[pixelInfo])!) / 255
        let green = CGFloat((data?[pixelInfo + 1])!) / 255
        let blue = CGFloat((data?[pixelInfo + 2])!) / 255
        let alpha = CGFloat((data?[pixelInfo + 3])!) / 255
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
}
