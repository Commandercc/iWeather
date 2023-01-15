//
//  WTLocationManager.swift
//  iweather
//
//  Created by zhengxu on 2023/1/12.
//

import Foundation

typealias confirmLocationCallBack = (WTLocation?, Error?) -> Void // 定位服务回调

final class WTLocationManager: NSObject {
    static let kToSaveLocations: String = "kToSaveLocations"
    static let shared = WTLocationManager()
    var searchLocationCallBack: (([WTLocation]?, Error?) -> Void)? // 地点检索服务回调
    var cachedLocations: [WTLocation] {
        if let data = UserDefaults.standard.data(forKey: WTLocationManager.kToSaveLocations) {
            do {
                return try JSONDecoder().decode([WTLocation].self, from: data)
            } catch {
                print(error)
            }
            return []
        }
        return []
    }

    private override init() {
        super.init()
    }

    // 地点检索
    func locationSearchService(keyword: String) {
        let suggestionOption = BMKSuggestionSearchOption()
        suggestionOption.keyword = keyword
        suggestionOption.cityname = "北京" // 这里虽然指定了搜索的城市区域，但是只是代表该城市内的地点优先级高
        suggestionOption.cityLimit = false // 是否指定只在cityName指定的城市里搜索

        let search = BMKSuggestionSearch()
        search.delegate = self
        let flag = search.suggestionSearch(suggestionOption)
        if flag {
            print("log log Sug检索发送成功")
        } else {
            print("log log Sug检索发送失败")
        }
    }
    
    // 定位服务
    func confirmLocationService(finish: @escaping confirmLocationCallBack) {
        let locationManager = BMKLocationManager()
        //locationManager.delegate = self
        locationManager.coordinateType = .BMK09LL // 设置返回的坐标系类型
        locationManager.distanceFilter = kCLDistanceFilterNone // 设置过滤参数
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters // 设置预期经度
        locationManager.activityType = .automotiveNavigation // 设置应用位置类型
        locationManager.pausesLocationUpdatesAutomatically = false // 设置是否自动停止位置更新
        locationManager.allowsBackgroundLocationUpdates = false // 是否允许后台定位
        locationManager.locationTimeout = 5 // 设置位置获取超时
        locationManager.reGeocodeTimeout = 5 // 设置地址信息获取超时
        
        locationManager.requestLocation(withReGeocode: true, withNetworkState: false) { (bmkLocation, state, error) in
            print("log log \(bmkLocation?.location?.coordinate)  \(bmkLocation?.rgcData?.description)")
            if let loc = bmkLocation?.location, let rgcData = bmkLocation?.rgcData {
                let tempLocation = WTLocation()
                tempLocation.location = Coordinate(loc.coordinate)
                if rgcData.town != nil {
                    tempLocation.name = "\(rgcData.town ?? "") \(rgcData.district ?? "")"
                } else if rgcData.district != nil {
                    tempLocation.name = "\(rgcData.district ?? "") \(rgcData.city ?? "")"
                } else {
                    tempLocation.name = "获取地区异常"
                }
                tempLocation.city = rgcData.city
                tempLocation.district = rgcData.district
                tempLocation.address = rgcData.locationDescribe
                finish(tempLocation, nil)
            } else {
                finish(nil, error)
            }
        }
    }
    
    func clearAllCachedLocations() {
        UserDefaults.standard.removeObject(forKey: WTLocationManager.kToSaveLocations)
    }
}

extension WTLocationManager: BMKSuggestionSearchDelegate {
    func onGetSuggestionResult(_ searcher: BMKSuggestionSearch!, result: BMKSuggestionSearchResult!, errorCode error: BMKSearchErrorCode) {
        print("log log \(result.suggestionList[0].location)")
        if let res = result.suggestionList {
            let responseLocations: [WTLocation] = res.map { suggestInfo in
                let loc = WTLocation()
                loc.name = suggestInfo.key
                loc.city = suggestInfo.city
                loc.district = suggestInfo.district
                loc.address = suggestInfo.address
                loc.id = suggestInfo.uid
                loc.location = Coordinate(suggestInfo.location)
                return loc
            }
            self.searchLocationCallBack?(responseLocations, nil)
        } else {
            self.searchLocationCallBack?([], nil)  // 处理错误情况
        }
    }
}
