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
    private let backWeatherImg = UIImageView(frame: .zero)
    
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
        self.view.addSubview(backWeatherImg)
        self.view.addSubview(scrollView)
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        backWeatherImg.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight)
        scrollView.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight)
        scrollView.contentSize = CGSize(width: 0, height: CGFloat.screenHeight * 1.5)
        
        backWeatherImg.image = UIImage(named: "hefengbg_100d")
        backWeatherImg.contentMode = .scaleToFill
    
        scrollView.addSubview(nowInfoView)
        nowInfoView.frame = CGRect(x: 0, y: CGFloat.navBarHeight, width: CGFloat.screenWidth, height: CGFloat.screenHeight / 2.0)
        scrollView.addSubview(daysInfoView)
        daysInfoView.frame = CGRect(x: 0, y: nowInfoView.bottom, width: CGFloat.screenWidth, height: 300)
        scrollView.addSubview(hoursInfoView)
        hoursInfoView.frame = CGRect(x: 0, y: daysInfoView.bottom, width: CGFloat.screenWidth, height: 150)
        scrollView.addSubview(todayIndiceInfoView)
        todayIndiceInfoView.frame = CGRect(x: 0, y: hoursInfoView.bottom, width: CGFloat.screenWidth, height: 300)
    }
    
    private func bindViewModel() {
        self.viewModel.loadCallBack = { [weak self] (now, dayList, hourList, indiceList, success) in
            guard let self = self else { return }
            if success {
                self.nowInfoView.updateValues(temp: now?.temp ?? "", desc: now?.text ?? "")
                self.daysInfoView.updateViews(dayList: dayList ?? [])
                self.hoursInfoView.updateViews(hours: hourList ?? [])
                self.todayIndiceInfoView.updateViews(indiceList: indiceList ?? [])
                CC.log("now: \(now)  daylist: \(dayList)     hourlist:  \(hourList)")
//                if let stateBg = UIImage(named: "hefengbg_100d") {
//                    self.scrollView.backgroundColor = UIColor(patternImage: stateBg)
//                }
            } else {
                self.view.makeToast("数据获取失败，请重试")
            }
        }
    }
    
    func loadDetailWeatherData() {
        self.viewModel.loadAllWeatherInfo()
    }
}
 
