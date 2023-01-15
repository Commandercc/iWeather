//
//  UIApplication+Addition.swift
//  iweather
//
//  Created by zhengxu on 2023/1/14.
//

import Foundation

extension UIApplication {
    var curKeyWindow: UIWindow? {
        get {
            if let windowScene = UIApplication.shared.connectedScenes.filter({ ($0 is UIWindowScene) }).first as? UIWindowScene, let curKeyWindow = windowScene.windows.filter({ $0.isKeyWindow }).first {
                return curKeyWindow
            }
            return nil
        }
    }
    
    var curKeyWindowScene: UIWindowScene? {
        get {
            if let windowScene = UIApplication.shared.connectedScenes.filter({ ($0.activationState == .foregroundActive) && ($0 is UIWindowScene) }).first as? UIWindowScene {
                return windowScene
            }
            return nil
        }
    }
    
    @objc func currentKeyWindow() -> UIWindow? {
        return self.curKeyWindow
    }
    
    @objc func currentKeyWindowScene() -> UIWindowScene? {
        return self.curKeyWindowScene
    }
}
