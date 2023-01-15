//
//  WTDetailPageListViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

import Foundation
import UIKit

final class WTDetailPageListViewController: CCBaseViewController {
    private var viewModel = WTDetailViewModel()
    private let scrollView = UIScrollView(frame: .zero)
    private let nowInfoView = WTNowInfoView(frame: .zero) // 今日天气
    private let daysInfoView = WTFeatureDaysInfoView(frame: .zero) // 未来x天天气
    private let hoursInfoView = WTFeatureHoursInfoView(frame: .zero) // 未来x时天气
    private let indiceInfoView = WTTodayIndiceInfoView(frame: .zero) // 天气指数
    
    init(locationId: String) {
        super.init()
        self.viewModel.currentLocationId = locationId
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewModel()
    }
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = WTBaseData.mainBackColor
        
        scrollView.addSubViews(views: [nowInfoView, daysInfoView, hoursInfoView, indiceInfoView])
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        let leftSpace: CGFloat = 10
        let childWidth: CGFloat = CGFloat.screenWidth - leftSpace * 2
        nowInfoView.snp.makeConstraints { make in
            make.top.equalTo(WTHomeViewController.TopHeight + 10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(300)
        }
        daysInfoView.snp.makeConstraints { make in
            make.top.equalTo(nowInfoView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(10 + 30 + 40 + FeatureDaysInfoItem.cellHeight * CGFloat(WTFeatureDaysInfoView.defaultLoadCount))
        }
        hoursInfoView.snp.makeConstraints { make in
            make.top.equalTo(daysInfoView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(10 + 30 + 125 + 10)
        }
        indiceInfoView.snp.makeConstraints { make in
            make.top.equalTo(hoursInfoView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(10 + 30 + 40 + IndiceDailyInfoItem.cellHeight * CGFloat(WTTodayIndiceInfoView.defaultLoadCount))
            make.bottom.equalToSuperview().offset(-CGFloat.safeBottom)
        }
        
        nowInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        daysInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        daysInfoView.layer.masksToBounds = true
        hoursInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        indiceInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        indiceInfoView.layer.masksToBounds = true
        
        daysInfoView.clickMoreClosure = { [weak self] height in
            self?.daysInfoView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
        
        indiceInfoView.clickMoreClosure = { [weak self] height in
            self?.indiceInfoView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
    
    private func bindViewModel() {
        self.viewModel.loadCallBack = { [weak self] (now, dayList, hourList, indiceList, success) in
            guard let self = self else { return }
            if success {
                if let now = now {
                    let data = self.convertToNowData(now: now)
                    self.nowInfoView.updateValues(data: data)
                }
                if let dayList = dayList {
                    let dataList = self.convertToDaysData(dailyList: dayList)
                    self.daysInfoView.updateViews(dataList: dataList)
                }
                if let hourList = hourList {
                    let dataList = self.convertToHoursData(hourList: hourList)
                    self.hoursInfoView.updateViews(dataList: dataList)
                }
                if let indiceList = indiceList {
                    let dataList = self.convertToIndicesData(indiceList: indiceList)
                    self.indiceInfoView.updateViews(dataList: dataList)
                }
                CC.log("now: \(now)  daylist: \(dayList)     hourlist:  \(hourList)  indiceList: \(indiceList)")

            } else {
                self.view.makeToast("数据获取失败，请重试")
            }
        }
    }
    
    func loadDetailWeatherData() {
        self.viewModel.loadAllWeatherInfo()
    }
    
    // to now
    func convertToNowData(now: Now) -> NowInfoDataModel {
        let nowData = NowInfoDataModel()
        nowData.windSpeed = now.windSpeed
        nowData.windScale = now.windScale
        nowData.windDir = now.windDir
        nowData.text = now.text
        nowData.vis = now.vis
        nowData.precip = now.precip
        nowData.humidity = now.humidity
        nowData.feelsLike = now.feelsLike
        nowData.temp = now.temp
        nowData.icon = now.icon
        nowData.pressure = now.pressure
        return nowData
    }
    
    // to days
    func convertToDaysData(dailyList: [Daily]) -> [FeatureDaysInfoDataModel] {
        return dailyList.map { daily in
            let data = FeatureDaysInfoDataModel()
            data.fxDate = daily.fxDate
            data.tempMax = daily.tempMax
            data.tempMin = daily.tempMin
            data.textDay = daily.textDay
            data.iconDay = daily.iconDay
            data.textNight = daily.textNight
            data.iconNight = daily.iconNight
            return data
        }
    }
    
    // to hours
    func convertToHoursData(hourList: [Hourly]) -> [FeatureHoursInfoDataModel] {
        return hourList.map { hour in
            let data = FeatureHoursInfoDataModel()
            data.fxTime = hour.fxTime
            data.temp = hour.temp
            data.icon = hour.icon
            data.windDir = hour.windDir
            data.windScale = hour.windScale
            data.text = hour.text
            data.windSpeed = hour.windSpeed
            return data
        }
    }
    
    // to indices
    func convertToIndicesData(indiceList: [IndicesDaily]) -> [IndiceDailyInfoDataModel] {
        return indiceList.map { indice in
            let data = IndiceDailyInfoDataModel()
            data.name = indice.name
            data.text = indice.text
            data.category = indice.category
            data.date = indice.date
            data.level = indice.level
            data.type = indice.type
            return data
        }
    }
}
 
