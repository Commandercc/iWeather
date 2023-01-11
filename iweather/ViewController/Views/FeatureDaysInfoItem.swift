//
//  FeatureDaysInfoItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class FeatureDaysInfoDataModel {
    var fxDate: String = "" // 预报日期
    var tempMax: String = "" // 最高温度
    var tempMin: String = "" // 最低温度
    var textDay: String = "" // 白天天气
    var iconDay: String = "" // 白天天气状态icon
    var textNight: String = "" // 夜晚天气
    var iconNight: String = "" // 夜晚天气状态icon
    var windDirDay: String = "" // 白天风向
    var windScaleDay: String = "" // 白天风力等级
    var WindDirNight: String = "" // 夜晚风向
    var windScaleNight: String = "" // 夜晚 风力等级
    
    init(fxDate: String = "", tempMax: String = "", tempMin: String = "", textDay: String = "", iconDay: String = "", textNight: String = "", iconNight: String = "", windDirDay: String = "", windScaleDay: String = "", WindDirNight: String = "", windScaleNight: String = "") {
        self.fxDate = fxDate
        self.tempMax = tempMax
        self.tempMin = tempMin
        self.textDay = textDay
        self.iconDay = iconDay
        self.textNight = textNight
        self.iconNight = iconNight
        self.windDirDay = windDirDay
        self.windScaleDay = windScaleDay
        self.WindDirNight = WindDirNight
        self.windScaleNight = windScaleNight
    }
}

final class FeatureDaysInfoItem: CCTableViewItem {
    let data: FeatureDaysInfoDataModel
    
    init(data: FeatureDaysInfoDataModel) {
        self.data = data
        super.init()
        self.cellHeight = 40
    }
}

final class FeatureDaysInfoCell: CCTableViewCell {
    private let iconView = UIImageView(frame: .zero) // 天气icon
    private let fxDateLabel = UILabel(frame: .zero) // 日期
    private let descLabel = UILabel(frame: .zero) // 天气描述
    private let tempLabel = UILabel(frame: .zero) // 最高气温 / 最低气温
    
    override var item: CCTableViewItem? {
        didSet {
            if let item = item as? FeatureDaysInfoItem {
                self.updateViews(data: item.data)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.contentView.addSubViews(views: [iconView, fxDateLabel, descLabel, tempLabel])
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        fxDateLabel.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right)
            make.centerY.equalTo(iconView.snp.centerY)
        }
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(fxDateLabel.snp.right).offset(5)
            make.centerY.equalTo(iconView.snp.centerY)
        }
        tempLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalTo(iconView.snp.centerY)
            
        }

        fxDateLabel.font = UIFont.Font(18)
        fxDateLabel.textColor = UIColor.white
        fxDateLabel.textAlignment = .left
        
        descLabel.font = UIFont.Font(18)
        descLabel.textColor = UIColor.white
        descLabel.textAlignment = .left
        
        tempLabel.font = UIFont.Font(18)
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .right
    }
    
    private func updateViews(data: FeatureDaysInfoDataModel) {
        iconView.image = UIImage(named: "hefengweather_100d")
        if data.textDay == data.textNight {
            descLabel.text = "\(data.textDay)转\(data.textNight)"
        } else {
            descLabel.text = data.textDay
        }
        fxDateLabel.text = data.fxDate
        tempLabel.text = "\(data.tempMax) ℃/ \(data.tempMin)℃"
    }
}
