//
//  WTLocationManager.swift
//  iweather
//
//  Created by zhengxu on 2023/1/12.
//

import Foundation
//
//final class WTLocationManager: NSObject, BMKSuggestionSearchDelegate {
//    static let shared = WTLocationManager()
//
//    private override init() {
//        super.init()
//    }
//
//    func keyWordSearchSuggestion(keyword: String) {
//        let suggestionOption = BMKSuggestionSearchOption()
//        suggestionOption.keyword = keyword
//        suggestionOption.cityname = "北京" // 这里虽然指定了搜索的城市区域，但是只是代表该城市内的地点优先级高
//        suggestionOption.cityLimit = false // 是否指定只在cityName指定的城市里搜索
//
//        let search = BMKSuggestionSearch()
//        search.delegate = self
//        let flag = search.suggestionSearch(suggestionOption)
//        if flag {
//            print("log log Sug检索发送成功")
//        } else {
//            print("log log Sug检索发送失败")
//        }
//    }
//
//    func onGetSuggestionResult(_ searcher: BMKSuggestionSearch!, result: BMKSuggestionSearchResult!, errorCode error: BMKSearchErrorCode) {
//        print("log log \(result)")
//    }
//}
