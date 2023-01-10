//
//  UIViewController+Addition.swift
//  thunder
//
//  Created by zhengxu on 2022/2/26.
//

import Foundation
import UIKit

extension UIViewController {
    
    var defaultNavigationController: UINavigationController {
        if self.isKind(of: UINavigationController.self) {
            return self as! UINavigationController
        } else if (self.navigationController != nil) {
            return self.navigationController!
        }
        let navController = UINavigationController(rootViewController: self)
        return navController
    }
    
    func changeNavigationBarAlpha(alpha: CGFloat) {
        if let bgImage = UIImage(UIColor.white.alpha(alpha)) {
            if #available(iOS 15.0, *) {
                if let appearance = self.navigationController?.navigationBar.standardAppearance {
                    appearance.backgroundImage = bgImage
                    self.navigationController?.navigationBar.standardAppearance = appearance
                    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
                }
            } else {
                self.navigationController?.navigationBar.setBackgroundImage(bgImage, for: .default)
            }
        }
    }
}

extension UINavigationController {
    func toTranslucent(_ translucent: Bool) {
        if #available(iOS 15.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            if translucent {
                navBarAppearance.configureWithTransparentBackground()
                navBarAppearance.backgroundImage = UIImage()
            } else {
                navBarAppearance.configureWithOpaqueBackground()
                navBarAppearance.backgroundImage = UIImage(UIColor.white)
            }
            self.navigationBar.standardAppearance = navBarAppearance
            self.navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            if translucent {
                self.navigationBar.setBackgroundImage(UIImage(), for: .default)
            } else {
                self.navigationBar.setBackgroundImage(UIImage(UIColor.white), for: .default)
            }
        }
    }
}
