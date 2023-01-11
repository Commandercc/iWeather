//
//  WTDetailViewModel.swift
//  iweather
//
//  Created by zhengxu on 2023/1/8.
//

import Foundation

final class WTDetailViewModel {
    var currentLocationId: String = ""
    private var nowInfo: Now?
    private var hourList: [Hourly]?
    private var dayList: [Daily]?
    private var indiceList: [IndicesDaily]?
    private let group: DispatchGroup = DispatchGroup()
    var loadCallBack: ((Now?, [Daily]?, [Hourly]?, [IndicesDaily]?, Bool) -> Void)?
    
    init() {}
    
    func loadAllWeatherInfo() {
        self.getNowWeatherInfo()
        self.get7DWeatherInfo()
        self.get24HWeatherInfo()
        self.getTodayWeatherIndices()
        self.group.notify(queue: DispatchQueue.main) {
            if self.nowInfo == nil || self.dayList == nil || self.hourList == nil || self.indiceList == nil {
                self.loadCallBack?(nil, nil, nil, nil, false)
            } else {
                self.loadCallBack?(self.nowInfo, self.dayList, self.hourList, self.indiceList, true)
            }
        }
    }
    
    // 获取now
    private func getNowWeatherInfo() {
        self.group.enter()
        WTHomeService.getNowWeatherInfo(locationId: self.currentLocationId) { [weak self] (weatherInfo, error) in
            guard let self = self else {
                self?.nowInfo = nil
                self?.group.leave()
                return
            }
            if let now = weatherInfo?.now {
                self.nowInfo = now
            } else {
                self.nowInfo = nil
            }
            self.group.leave()
        }
    }
    
    // 获取7D
    private func get7DWeatherInfo() {
        self.group.enter()
        WTHomeService.get7DWeatherInfo(locationId: self.currentLocationId) { [weak self] (weatherInfo, error) in
            guard let self = self else {
                self?.dayList = nil
                self?.group.leave()
                return
            }
            if let dayList = weatherInfo?.daily {
                self.dayList = dayList
            } else {
                self.dayList = nil
            }
            self.group.leave()
        }
    }
    
    // 获取24h
    private func get24HWeatherInfo() {
        self.group.enter()
        WTHomeService.get24HWeatherInfo(locationId: self.currentLocationId) { [weak self] (weatherInfo, error) in
            guard let self = self else {
                self?.hourList = nil
                self?.group.leave()
                return
            }
            if let hourList = weatherInfo?.hourly {
                self.hourList = hourList
            } else {
                self.hourList = nil
            }
            self.group.leave()
        }
    }
    
    // 获取今日天气指数
    private func getTodayWeatherIndices() {
        self.group.enter()
        WTHomeService.getTodayWeatherIndices(locationId: self.currentLocationId) { [weak self] (indices, error) in
            guard let self = self else {
                self?.indiceList = nil
                self?.group.leave()
                return
            }
            if let indiceList = indices?.daily {
                self.indiceList = indiceList
            } else {
                self.indiceList = nil
            }
            self.group.leave()
        }
    }
}
