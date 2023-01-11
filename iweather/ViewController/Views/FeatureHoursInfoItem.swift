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
    
    init(fxTime: String = "", temp: String = "", icon: String = "", text: String = "", windDir: String = "", windScale: String = "") {
        self.fxTime = fxTime
        self.temp = temp
        self.icon = icon
        self.text = text
        self.windDir = windDir
        self.windScale = windScale
    }
}

final class FeatureHoursInfoItem: CCCollectionViewItem {
    let data: FeatureHoursInfoDataModel
    
    init(data: FeatureHoursInfoDataModel) {
        self.data = data
        super.init()
        self.cellHeight = 150
    }
}

final class FeatureHoursInfoCell: CCCollectionViewCell {
    private let fxTimeLabel = UILabel(frame: .zero)
    private let tempLabel = UILabel(frame: .zero)
    private let iconView = UIImageView(frame: .zero)
    private let windDirLabel = UILabel(frame: .zero)
    
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
        self.contentView.addSubViews(views: [fxTimeLabel, tempLabel, iconView, windDirLabel])
        fxTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(fxTimeLabel.snp.bottom)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
        }
        iconView.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        windDirLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.bottom)
            make.centerX.equalTo(fxTimeLabel.snp.centerX)
        }
        
        fxTimeLabel.font = UIFont.Font(10)
        fxTimeLabel.textColor = UIColor.white
        tempLabel.font = UIFont.Font(10)
        tempLabel.textColor = UIColor.white
        windDirLabel.font = UIFont.Font(10)
        windDirLabel.textColor = UIColor.white
    }
    
    func updateViews(data: FeatureHoursInfoDataModel) {
        fxTimeLabel.text = data.fxTime
        tempLabel.text = data.temp
        windDirLabel.text = "\(data.windDir).\(data.windScale)级"
    }
}
