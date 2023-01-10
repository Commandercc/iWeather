//
//  WTHomeViewModel.swift
//  iweather
//
//  Created by zhengxu on 2023/1/9.
//

import Foundation

final class WTHomeViewModel {
    private let kSavedLocationIds : String = "kSavedLocationIds"
    private var locationIds: [String] = []
    
    init() {
        if let locations = UserDefaults.standard.array(forKey: kSavedLocationIds)  as? [String] {
            self.locationIds = locations
        } else {
            // 提示引导去添加城市
            
        }
    }
}
