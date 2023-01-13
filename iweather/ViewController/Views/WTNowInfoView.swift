//
//  WTNowInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/10.
//

import Foundation
import UIKit

final class WTNowInfoView: UIView {
    private let tempLabel = UILabel(frame: .zero) // 温度
    private let weatherDesc = UILabel(frame: .zero) // 天气描述
    private let degreeImg = UIImageView(image: UIImage(named: "icon_temp_degree"))
    private let windLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = WTBaseData.moduleBackColor
        self.addSubViews(views: [tempLabel, weatherDesc, windLabel])
        tempLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        weatherDesc.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        windLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDesc.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        
        tempLabel.font = UIFont.BoldFont(50)
        tempLabel.textColor = WTBaseData.mainTitleColor
        weatherDesc.font = UIFont.Font(20)
        weatherDesc.textColor = WTBaseData.mainTitleColor
        windLabel.font = UIFont.Font(16)
        windLabel.textColor = WTBaseData.mainTitleColor
    }
    
    func updateValues(data: NowInfoDataModel) {
        tempLabel.text = "\(data.temp)°"
        weatherDesc.text = "\(data.text)"
        windLabel.text = "\(data.windDir)\(data.windScale)级，风速:\(data.windSpeed)千米/小时"
        let bottomContentView = UIView(frame: .zero)
        self.addSubview(bottomContentView)
        bottomContentView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(120)
        }
        
        // 构造几组atomicData
        let data1 = WTNowInfoAtomicData(title: "体感温度", subTitle: "\(data.feelsLike)°") // 体感温度 -1°
        let data2 = WTNowInfoAtomicData(title: "湿度", subTitle: "\(data.humidity)%") // 湿度 33%
        let data3 = WTNowInfoAtomicData(title: "降雨量", subTitle: "\(data.precip)毫米") // 20毫米
        let data4 = WTNowInfoAtomicData(title: "能见度", subTitle: "\(data.vis)千米") // 1千米
        
        let atomic1 = WTNowInfoAtomicView(frame: .zero)
        let atomic2 = WTNowInfoAtomicView(frame: .zero)
        let atomic3 = WTNowInfoAtomicView(frame: .zero)
        let atomic4 = WTNowInfoAtomicView(frame: .zero)

        bottomContentView.addSubViews(views: [atomic1, atomic2, atomic3, atomic4])
        atomic1.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        atomic1.updateViews(data: data1)
        atomic2.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        atomic2.updateViews(data: data2)
        atomic3.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        atomic3.updateViews(data: data3)
        atomic4.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        atomic4.updateViews(data: data4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        WTPermissionManager().checkLocationStatus()
    }
}

final class WTNowInfoAtomicData {
    var title: String = ""
    var subTitle: String = ""
    
    init(title: String = "", subTitle: String = "") {
        self.title = title
        self.subTitle = subTitle
    }
}

final class WTNowInfoAtomicView: UIView {
    private let titleLabel = UILabel(frame: .zero)
    private let subTitleLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubViews(views: [titleLabel, subTitleLabel])
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        titleLabel.font = UIFont.Font(16)
        titleLabel.textColor = WTBaseData.subTitleColor
        subTitleLabel.font = UIFont.Font(18)
        subTitleLabel.textColor = WTBaseData.mainTitleColor
    }
    
    func updateViews(data: WTNowInfoAtomicData) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
    }
}
