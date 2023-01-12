//
//  CGFloat+Addition.swift
//  thunder
//
//  Created by zhengxu on 2022/2/23.
//

import CoreGraphics
import UIKit

extension CGFloat {
    // system
    static var screenWidth: CGFloat { return UIScreen.main.bounds.width }
    static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    static var screenScale: CGFloat { return UIScreen.main.scale }
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? UIApplication.shared.statusBarFrame.height
    }
    static var safeBottom: CGFloat { return isFullScreen ? 34 : 0 }
    static var navBarHeight: CGFloat { return isFullScreen ? (44 + statusBarHeight) : 64.0 }
    static var tabBarHeight: CGFloat { return isFullScreen ? (49 + safeBottom) : 49 }
    
    // custom
    static var segmentHeight: CGFloat { return 44 }
}
