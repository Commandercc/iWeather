//
//  WTHomeService.swift
//  iweather
//
//  Created by zhengxu on 2023/1/8.
//

import Foundation

typealias WeatherRequestCallBack = (WeatherBaseClass?, Error?) -> Void // 天气状况回调
typealias IndicesRequestCallBack = (IndicesBaseClass?, Error?) -> Void // 天气指数回调

final class WTHomeService {
    // 获取实时天气信息
    static func getNowWeatherInfo(locationId: String, finish: @escaping WeatherRequestCallBack) {
        AllWeatherInquieirs.sharedInstance().location = locationId
        AllWeatherInquieirs.sharedInstance().weather(withInquireType: .WEATHER_NOW) { obj in
            if let obj = obj as? WeatherBaseClass {
                finish(obj, nil)
            } else {
                finish(nil, nil)
            }
        } faileureForError: { error in
            finish(nil, error)
        }
    }
    
    // 获取未来7天(包含今日)天气信息
    static func get7DWeatherInfo(locationId: String, finish: @escaping WeatherRequestCallBack) {
        AllWeatherInquieirs.sharedInstance().location = locationId
        AllWeatherInquieirs.sharedInstance().weather(withInquireType: .WEATHER_7D) { obj in
            if let obj = obj as? WeatherBaseClass {
                finish(obj, nil)
            } else {
                finish(nil, nil)
            }
        } faileureForError: { error in
            finish(nil, error)
        }
    }
    
    // 获取未来24小时天气信息
    static func get24HWeatherInfo(locationId: String, finish: @escaping WeatherRequestCallBack) {
        AllWeatherInquieirs.sharedInstance().location = locationId
        AllWeatherInquieirs.sharedInstance().weather(withInquireType: .WEATHER_24H) { obj in
            if let obj = obj as? WeatherBaseClass {
                finish(obj, nil)
            } else {
                finish(nil, nil)
            }
        } faileureForError: { error in
            finish(nil, error)
        }
    }
    
    // 获取今日天气指数信息
    static func getTodayWeatherIndices(locationId: String, finish: @escaping IndicesRequestCallBack) {
        AllWeatherInquieirs.sharedInstance().location = locationId
        AllWeatherInquieirs.sharedInstance().weather(withInquireType: .INDICES_1D) { obj in
            if let obj = obj as? IndicesBaseClass {
                finish(obj, nil)
            } else {
                finish(nil, nil)
            }
        } faileureForError: { error in
            finish(nil, error)
        }
    }
}
