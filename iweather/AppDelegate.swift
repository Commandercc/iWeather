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
        //BMKMapManager.setAgreePrivacy(true) // 假设用户同意百度地图的隐私协议
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

