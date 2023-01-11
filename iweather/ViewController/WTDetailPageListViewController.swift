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
    private let todayIndiceInfoView = WTTodayIndiceInfoView(frame: .zero) // 天气指数
    
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
        print("log log 执行了viewDidLoad")
    }
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = WTBaseData.mainBackColor
        
        scrollView.addSubViews(views: [nowInfoView, daysInfoView, hoursInfoView, todayIndiceInfoView])
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
            make.height.equalTo(200)
        }
        hoursInfoView.snp.makeConstraints { make in
            make.top.equalTo(daysInfoView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(200)
        }
        todayIndiceInfoView.snp.makeConstraints { make in
            make.top.equalTo(hoursInfoView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(leftSpace)
            make.width.equalTo(childWidth)
            make.right.equalToSuperview().offset(-leftSpace)
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
        
        nowInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        daysInfoView.layer.cornerRadius = WTBaseData.moduleCornerRadius
        daysInfoView.layer.masksToBounds = true
        
        daysInfoView.clickMoreClosure = { [weak self] height in
            self?.daysInfoView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
        }
    }
    
    private func bindViewModel() {
        self.viewModel.loadCallBack = { [weak self] (now, dayList, hourList, indiceList, success) in
            guard let self = self else { return }
            if success {
                if let now = now {
                    let nowData = self.convertToNowData(now: now)
                    self.nowInfoView.updateValues(data: nowData)
                }
                if let dayList = dayList {
                    let dailyList = self.convertToDaysData(dailyList: dayList)
                    self.daysInfoView.updateViews(dataList: dailyList)
                }
//                self.hoursInfoView.updateViews(hours: hourList ?? [])
//                self.todayIndiceInfoView.updateViews(indiceList: indiceList ?? [])
                CC.log("now: \(now)  daylist: \(dayList)     hourlist:  \(hourList)")

            } else {
                self.view.makeToast("数据获取失败，请重试")
            }
        }
    }
    
    func loadDetailWeatherData() {
        self.viewModel.loadAllWeatherInfo()
    }
    
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
}
 
