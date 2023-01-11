//
//  NowInfoItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class NowInfoDataModel {
    var temp: String = "" // 温度
    var icon: String = "" // 天气状况和图标的代码
    var text: String = "" // 天气状况的文字描述
    var windDir: String = "" // 风向
    var windScale: String = "" // 风力等级
    var windSpeed: String = "" // 风速
    var humidity: String = "" // 相对湿度，百分比数值
    var precip: String = "" // 当前小时累计降水量，默认单位：毫米
    var pressure: String = "" // 大气压强，默认单位：百帕
    var vis: String = "" // 能见度，默认单位：公里
    var feelsLike: String = "" // 体感温度
    
    init(temp: String = "", icon: String = "", text: String = "", windDir: String = "", windScale: String = "", windSpeed: String = "", humidity: String = "", precip: String = "", pressure: String = "", vis: String = "", feelsLike: String = "") {
        self.temp = temp
        self.icon = icon
        self.text = text
        self.windDir = windDir
        self.windScale = windScale
        self.windSpeed = windSpeed
        self.humidity = humidity
        self.precip = precip
        self.pressure = pressure
        self.vis = vis
        self.feelsLike = feelsLike
    }
}
