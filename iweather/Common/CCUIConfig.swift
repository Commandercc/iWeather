//
//  CCUIConfig.swift
//  thunder
//
//  Created by zhengxu on 2022/3/7.
//

import Foundation
import UIKit

let isIPhoneX_XS = (CGFloat.screenWidth == 375 && CGFloat.screenHeight == 812) || (CGFloat.screenWidth == 812 && CGFloat.screenHeight == 375)
let isIPhoneXR_XSMax = (CGFloat.screenWidth == 414 && CGFloat.screenHeight == 896) || (CGFloat.screenWidth == 896 && CGFloat.screenHeight == 414)
let isIPhone12_12Pro = (CGFloat.screenWidth == 390 && CGFloat.screenHeight == 844) || (CGFloat.screenWidth == 844 && CGFloat.screenHeight == 390)
let isIPhone12mini = (CGFloat.screenWidth == 360 && CGFloat.screenHeight == 780) || (CGFloat.screenWidth == 780 && CGFloat.screenHeight == 360)
let isIPhone12ProMax = (CGFloat.screenWidth == 428 && CGFloat.screenHeight == 926) || (CGFloat.screenWidth == 926 && CGFloat.screenHeight == 428)
let isIPhone14_14Pro = (CGFloat.screenWidth == 393 && CGFloat.screenHeight == 852) || (CGFloat.screenWidth == 852 && CGFloat.screenHeight == 393)
let isIPhone14_14ProMax = (CGFloat.screenWidth == 430 && CGFloat.screenHeight == 932) || (CGFloat.screenWidth == 932 && CGFloat.screenHeight == 430)
let isFullScreen = isIPhoneX_XS || isIPhoneXR_XSMax || isIPhone12mini || isIPhone12_12Pro || isIPhone12ProMax || isIPhone14_14Pro || isIPhone14_14ProMax || (UIApplication.shared.statusBarFrame.size.height == 44)

extension UIColor {
    static var redTheme: UIColor { return UIColor.xEB0029 }
    static var grayText: UIColor { return UIColor.x707070 }
    
    static var lineColor: UIColor { return UIColor.xEEEEEE }
}

extension UIFont {
    static var bigTitleFont: UIFont { return UIFont.Font(20) } // height: 24
    static var segmentFont: UIFont { return UIFont.Font(17) } // 21
    static var titleFont: UIFont { return UIFont.Font(15) } // 18
    static var subTitleFont: UIFont { return UIFont.Font(13) } //16
    static var thirdTitleFont: UIFont { return UIFont.Font(12) } //14
}

