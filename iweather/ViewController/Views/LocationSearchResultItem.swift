//
//  LocationSearchResultItem.swift
//  iweather
//
//  Created by zhengxu on 2023/1/15.
//

import Foundation

final class LocationSearchResultItem: CCTableViewItem {
    let location: WTLocation
    
    init(location: WTLocation) {
        self.location = location
        super.init()
        self.cellHeight = 60
    }
}

final class LocationSearchResultCell: CCTableViewCell {
    private let nameLabel = UILabel(frame: .zero)
    
    override var item: CCTableViewItem? {
        didSet {
            if let item = item as? LocationSearchResultItem {
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
        backView.layer.cornerRadius = 5
        backView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        backView.addSubViews(views: [nameLabel])
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        
        nameLabel.font = UIFont.Font(20)
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = .left
    }
    
    private func updateViews(item: LocationSearchResultItem) {
        nameLabel.text = item.location.name
    }
}

