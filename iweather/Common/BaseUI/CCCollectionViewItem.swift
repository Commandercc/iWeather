//
//  CCCollectionViewItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

class CCCollectionViewItem: NSObject {
    var cellHeight: CGFloat = 0
    var cellClassName: String = ""   // eg: FunPlayIOS.FSMineSettingCell
    
    override init() {
        super.init()
        cellClassName = NSStringFromClass(type(of: self)).replacingOccurrences(of: "Item", with: "Cell")
    }
}

class CCCollectionViewCell: UICollectionViewCell {
    var item: CCCollectionViewItem?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.item = nil
    }
}
