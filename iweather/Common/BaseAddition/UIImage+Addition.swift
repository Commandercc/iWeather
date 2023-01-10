//
//  UIImage+Addition.swift
//  thunder
//
//  Created by zhengxu on 2022/2/26.
//

import Foundation
import UIKit

extension UIImage {
    
    //    private func from(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
    //        let format = UIGraphicsImageRendererFormat()
    //        format.scale = 1
    //        return UIGraphicsImageRenderer(size: size, format: format).image { context in
    //            color.setFill()
    //            context.fill(CGRect(origin: .zero, size: size))
    //        }
    //    }
    //
    //    private func from(color: UIColor, size: CGFloat = 1) -> UIImage {
    //        return from(color: color, size: CGSize(width: size, height: size))
    //    }
    //
    //    private func from(color: UIColor) -> UIImage {
    //        return from(color: color, size: 1)
    //    }
    
    
    
    convenience init?(_ color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        let image = UIGraphicsImageRenderer(size: size, format: format).image { context in
            color.setFill()
            context.fill(CGRect(origin: .zero, size: size))
        }
        guard let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
