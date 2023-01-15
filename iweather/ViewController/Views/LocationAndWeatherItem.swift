//
//  LocationAndWeatherItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/15.
//

import Foundation

final class LocationAndWeatherItem: CCTableViewItem {
    let location: WTLocation // 地点信息
    var temp: String = "" // 当前温度
    var wDesc: String = "" // 当前天气描述
    
    init(location: WTLocation, temp: String = "", wDesc: String = "") {
        self.location = location
        super.init()
        self.temp = temp
        self.wDesc = wDesc
        self.cellHeight = 100
    }
}

final class LocationAndWeatherCell: CCTableViewCell {
    private let nameLabel = UILabel(frame: .zero) // 地点名
    private let tempLabel = UILabel(frame: .zero) // 温度
    private let wDescLabel = UILabel(frame: .zero) // 天气描述
    
    override var item: CCTableViewItem? {
        didSet {
            if let item = item as? LocationAndWeatherItem {
                self.updateViews(item: item)
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
        let backView = UIView(frame: .zero)
        self.contentView.addSubview(backView)
        backView.backgroundColor = WTBaseData.mainBackColor
        backView.layer.cornerRadius = 10
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        backView.addSubViews(views: [nameLabel, tempLabel, wDescLabel])
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        wDescLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(15)
            make.right.lessThanOrEqualTo(tempLabel.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.width.equalTo(80)
        }
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        wDescLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        nameLabel.font = UIFont.Font(18)
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = .left
        nameLabel.lineBreakMode = .byTruncatingTail
        
        wDescLabel.font = UIFont.Font(18)
        wDescLabel.textColor = UIColor.black
        wDescLabel.textAlignment = .left
        
        tempLabel.font = UIFont.Font(30)
        tempLabel.textColor = UIColor.black
        tempLabel.textAlignment = .center
    }
    
    private func updateViews(item: LocationAndWeatherItem) {
        nameLabel.text = item.location.name
        wDescLabel.text = item.wDesc
        tempLabel.text = item.temp
    }
}
