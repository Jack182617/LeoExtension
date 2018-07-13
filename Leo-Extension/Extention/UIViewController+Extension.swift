//
//  UIViewController+Extension.swift
//  fangyizhanC
//
//  Created by apple on 2018/7/2.
//  Copyright © 2018年 fyz. All rights reserved.
//

import Foundation
import UIKit

let LEFT = 1, RIGHT = 2, TOP = 3, BOTTOM = 4, CENTER = 5

typealias SureAlertClickBlock = (() -> ())?

typealias SelectedIndexBlock = ((String,Int) -> ())?

extension UIViewController{
    
    func showBack() {
        let item = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = item
    }
    @objc func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showBackWithColor(color:UIColor) {
        let item = UIBarButtonItem.init(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(back))
        item.tintColor = color
        self.navigationItem.leftBarButtonItem = item
    }
    
    /**
     添加文字形式的BarButton
     
     - parameter position: 位置LEFT or RIGHT
     - parameter withStr:  文字
     */
    func showBarButtonItem(position:Int, withStr:String) {
        
        let width = withStr.widthWithConstrainedWidth(width: kScreenWidth / 2, font: UIFont.systemFont(ofSize: 16))
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(withStr, for: UIControlState.normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .disabled)
        let item = UIBarButtonItem(customView: btn)
        if LEFT == position {
            self.navigationItem.leftBarButtonItem = item
            btn.addTarget(self, action: #selector(leftNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        } else if RIGHT == position {
            self.navigationItem.rightBarButtonItem = item
            btn.addTarget(self, action: #selector(rightNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        }
    }
    
    @objc func leftNavBarButtonClicked() {
        FMLog(log: "\(type(of: self)) leftNavBarButtonClicked")
    }
    
    @objc func rightNavBarButtonClicked() {
        FMLog(log: " \(type(of: self)) leftNavBarButtonClicked")
    }
    
    //添加文字形式的带颜色的按钮
    func showBarButtonItemWithColor(position:Int, withStr:String,color:UIColor) {
        
        let width = withStr.widthWithConstrainedWidth(width: kScreenWidth / 2, font: UIFont.systemFont(ofSize: 16))
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.setTitle(withStr, for: UIControlState.normal)
        btn.setTitleColor(color, for: .normal)
        btn.setTitleColor(color, for: .disabled)
        let item = UIBarButtonItem(customView: btn)
        if LEFT == position {
            self.navigationItem.leftBarButtonItem = item
            btn.addTarget(self, action: #selector(leftNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        } else if RIGHT == position {
            self.navigationItem.rightBarButtonItem = item
            btn.addTarget(self, action: #selector(rightNavBarButtonClicked), for: UIControlEvents.touchUpInside)
        }
    }
    
    final func pushViewController(viewContoller: UIViewController, animated:Bool) {
        self.navigationController?.pushViewController(viewContoller, animated: animated)
    }
    
    final func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //提示
    final func showNoticeAlertView(title:String,message:String,leftStr:String,rightStr:String,sureAlertClickBlock:SureAlertClickBlock){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: leftStr, style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: rightStr, style: .default, handler: {
            action in
            
            if nil != sureAlertClickBlock{
                sureAlertClickBlock!()
            }
            
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //提示选择
    final func showSelectActionSheet(title:String,message:String,items:[String],selectedBlock:SelectedIndexBlock){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for item in items {
            let actTion = UIAlertAction.init(title: item, style: .default, handler: { (act) in
                if nil != selectedBlock{
                    selectedBlock!(act.title!,items.index(of: act.title!)!)
                }
            })
            
            alertController.addAction(actTion)
        }
        let canCelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(canCelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //关闭已打开的键盘
    final func CloseKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
