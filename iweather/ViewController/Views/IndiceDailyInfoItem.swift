//
//  IndiceDailyInfoItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class IndiceDailyInfoDataModel {
    var name: String = "" // 天气指数名称
    var level: String = "" // 指数等级
    var date: String = "" // 对应日期
    var text: String = "" // 描述和建议
    var type: String = "" // 指数类型
    var category: String = "" // 指数情况概况
    
    init(name: String = "", level: String = "", date: String = "", text: String = "", type: String = "", category: String = "") {
        self.name = name
        self.level = level
        self.date = date
        self.text = text
        self.type = type
        self.category = category
    }
}

final class IndiceDailyInfoItem: CCTableViewItem {
    let data: IndiceDailyInfoDataModel
    
    init(data: IndiceDailyInfoDataModel) {
        self.data = data
        super.init()
        self.cellHeight = 40
    }
}

final class IndiceDailyInfoCell: CCTableViewCell {
    private let indiceName = UILabel(frame: .zero) // 天气指数名
    private let indiceCategory = UILabel(frame: .zero) // 天气指数情况
    private let indiceDesc = UILabel(frame: .zero) // 描述和建议
    
    override var item: CCTableViewItem? {
        didSet {
            if let item = item as? IndiceDailyInfoItem {
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
        contentView.addSubViews(views: [indiceName, indiceCategory, indiceDesc])
        indiceName.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        indiceCategory.snp.makeConstraints { make in
            make.centerY.equalTo(indiceName.snp.centerY)
            make.left.equalTo(indiceName.snp.right).offset(10)
            make.right.lessThanOrEqualToSuperview()
        }
        indiceDesc.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(indiceName.snp.bottom).offset(10)
            make.right.lessThanOrEqualToSuperview()
        }
        
        indiceName.font = UIFont.Font(20)
        indiceName.textColor = UIColor.white
        indiceCategory.font = UIFont.Font(20)
        indiceCategory.textColor = UIColor.white
        indiceDesc.font = UIFont.Font(10)
        indiceDesc.textColor = UIColor.white
        indiceDesc.numberOfLines = 2
        indiceDesc.lineBreakMode = .byTruncatingTail
    }
    
    private func updateViews(data: IndiceDailyInfoDataModel) {
        indiceName.text = data.name
        indiceCategory.text = data.category
        indiceDesc.text = data.text
    }
}
 
