//
//  AppDelegate.swift
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

import UIKit
import FLEX

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Debug环境默认开启FLEX工具
        #if DEBUG || TEST
        FLEXManager.shared.showExplorer()
        #endif
        
        // 配置和风天气SDK
        AllWeatherInquieirs.sharedInstance().publicID = WTBaseData.iWeatherPublicId
        AllWeatherInquieirs.sharedInstance().appKey = WTBaseData.iWeatherKey
//        AllWeatherInquieirs.sharedInstance().appType = .DEV
        
        // 设置百度地图SDK
        BMKMapManager.sharedInstance().start(WTBaseData.iBaiduKey, generalDelegate: self) // 设置基础服务百度ak鉴权
        BMKLocationAuth.sharedInstance().checkPermision(withKey: WTBaseData.iBaiduKey, authDelegate: self) // 设置定位服务ak鉴权
        BMKMapManager.setAgreePrivacy(true) // 假设用户同意百度地图的隐私协议
        BMKLocationAuth.sharedInstance().setAgreePrivacy(true)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

// 百度地图SDK鉴权结果回调
extension AppDelegate: BMKGeneralDelegate {
    func onGetPermissionState(_ iError: Int32) {
        if iError == 0 {
            print("地图服务授权成功")
        } else {
            print("地图服务授权失败: \(iError)")
        }
    }
}

// 百度定位SDK鉴权结果回调
extension AppDelegate: BMKLocationAuthDelegate {
    func onCheckPermissionState(_ iError: BMKLocationAuthErrorCode) {
        if iError == .success {
            print("定位服务授权成功")
        } else {
            print("定位服务授权失败: \(iError)")
        }
    }
}


