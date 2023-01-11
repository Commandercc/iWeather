//
//  WTFeatureDaysInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/10.
//

import Foundation
import UIKit

final class WTFeatureDaysInfoView: UIView {
    static let dayInfoCellHeight: CGFloat = 40
    private let tableView = UITableView(frame: .zero)
    private let moreBtn = UIButton(frame: .zero)
    var cellItems: [CCTableViewItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubview(tableView)
        self.addSubview(moreBtn)
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(0)
        }
        moreBtn.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(40)
        }
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = UIColor.clear
        
        moreBtn.setTitle("查看近15天天气", for: .normal)
        moreBtn.setTitleColor(UIColor.white, for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.titleLabel?.font = UIFont.Font(20)
        
        self.moreBtn.isHidden = true
    }
    
    func updateViews(dayList: [Daily]) {
        guard !dayList.isEmpty else { return }
        self.cellItems = dayList.prefix(3).map({ daily in
            let data = FeatureDaysInfoDataModel()
            data.fxDate = daily.fxDate
            data.tempMax = daily.tempMax
            data.tempMin = daily.tempMin
            data.textDay = daily.textDay
            data.iconDay = daily.iconDay
            data.textNight = daily.textNight
            data.iconNight = daily.iconNight
            return FeatureDaysInfoItem(data: data)
        })
        self.tableView.snp.updateConstraints { make in
            make.height.equalTo(WTFeatureDaysInfoView.dayInfoCellHeight * CGFloat(self.cellItems.count))
        }
        self.tableView.reloadData()
        self.moreBtn.isHidden = false
    }
}

extension WTFeatureDaysInfoView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.cellItems[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: item.cellClassName) as? CCTableViewCell
        if cell == nil {
            cell = CCObjectGenerateFromClassString.createObjectGenerate(fromClassString: item.cellClassName) as? CCTableViewCell
        }
        cell?.item = item
        cell?.selectionStyle = .none
        cell?.backgroundView?.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        return cell ?? CCTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.cellItems[indexPath.row]
        return item.cellHeight
    }
}
