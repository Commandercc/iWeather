//
//  FeatureHoursInfoItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class FeatureHoursInfoDataModel {
    var fxTime: String = "" // 预报时间
    var temp: String = "" // 温度
    var icon: String = "" // 天气状况和图标的代码
    var text: String = "" // 天气状况的文字描述
    var windDir: String = "" // 风向
    var windScale: String = "" // 风力等级
    var windSpeed: String = "" // 风速
    
    init(fxTime: String = "", temp: String = "", icon: String = "", text: String = "", windDir: String = "", windScale: String = "", windSpeed: String = "") {
        self.fxTime = fxTime
        self.temp = temp
        self.icon = icon
        self.text = text
        self.windDir = windDir
        self.windScale = windScale
        self.windSpeed = windSpeed
    }
}

final class FeatureHoursInfoItem: CCCollectionViewItem {
    let data: FeatureHoursInfoDataModel
    
    init(data: FeatureHoursInfoDataModel) {
        self.data = data
        super.init()
    }
}

final class FeatureHoursInfoCell: CCCollectionViewCell {
    private let fxTimeLabel = UILabel(frame: .zero) // 时间
    private let tempLabel = UILabel(frame: .zero) // 温度
    private let iconView = UIImageView(frame: .zero) // 图标
    private let windDirLabel = UILabel(frame: .zero) // 风力
    private let windSpeedLabel = UILabel(frame: .zero) // 风速
    private let weatherDesc = UILabel(frame: .zero) // 天气描述
    
    override var item: CCCollectionViewItem? {
        didSet {
            if let item = item as? FeatureHoursInfoItem {
                self.updateViews(data: item.data)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let backView = UIView(frame: .zero)
        self.contentView.addSubview(backView)
        backView.backgroundColor = WTBaseData.mainBackColor
        backView.layer.cornerRadius = 5
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        backView.addSubViews(views: [fxTimeLabel, iconView, weatherDesc, tempLabel , windDirLabel, windSpeedLabel])
        fxTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        iconView.snp.makeConstraints { make in
            make.top.equalTo(fxTimeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        weatherDesc.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom).offset(5)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherDesc.snp.bottom).offset(5)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        windDirLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(5)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(windDirLabel.snp.bottom).offset(5)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
        }
        
        fxTimeLabel.font = UIFont.Font(10)
        fxTimeLabel.textColor = WTBaseData.mainTitleColor
        weatherDesc.font = UIFont.Font(10)
        weatherDesc.textColor = WTBaseData.mainTitleColor
        tempLabel.font = UIFont.Font(10)
        tempLabel.textColor = WTBaseData.mainTitleColor
        windDirLabel.font = UIFont.Font(10)
        windDirLabel.textColor = WTBaseData.mainTitleColor
        windSpeedLabel.font = UIFont.Font(10)
        windSpeedLabel.textColor = WTBaseData.mainTitleColor
    }
    
    func updateViews(data: FeatureHoursInfoDataModel) {
        fxTimeLabel.text = data.fxTime
        tempLabel.text = "\(data.temp)°"
        windDirLabel.text = "\(data.windDir).\(data.windScale)级"
        iconView.image = UIImage(named: "hefengweather_306d")
        weatherDesc.text = data.text
        windSpeedLabel.text = "风速 \(data.windSpeed) 千米/小时"
    }
}
