//
//  WTTodayIndiceInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class WTTodayIndiceInfoView: WTModuleBaseView {
    var clickMoreClosure: ((CGFloat) -> Void)?
    static let defaultLoadCount: Int = 5 // 默认列表加载数量
    private let tableView = UITableView(frame: .zero)
    private var isExpand: Bool = false // 标志是否是展开状态
    private var dataList: [IndiceDailyInfoDataModel] = []
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
        self.backgroundColor = WTBaseData.moduleBackColor
        self.addSubview(tableView)
        self.addSubview(moreBtn)
        
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(topTilte.snp.bottom)
            make.height.equalTo(0)
        }
        moreBtn.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        topTilte.text = "今日生活指数"
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        moreBtn.setTitle("展开更多", for: .normal)
        moreBtn.setTitleColor(WTBaseData.mainTitleColor, for: .normal)
        moreBtn.titleLabel?.textAlignment = .center
        moreBtn.titleLabel?.font = UIFont.Font(15)
        moreBtn.addTarget(self, action: #selector(moreBtnClockEvent), for: .touchUpInside)
        self.moreBtn.isHidden = true
    }
    
    func updateViews(dataList: [IndiceDailyInfoDataModel]) {
        guard !dataList.isEmpty else { return }
        self.isExpand = false
        self.dataList = dataList
        self.moreBtn.isHidden = false
        self.handleTableEvent(isExpand: self.isExpand)
    }
    
    private func handleTableEvent(isExpand: Bool) {
        if isExpand { // 展开
            self.cellItems = self.dataList.map({ data in
                return IndiceDailyInfoItem(data: data)
            })
        } else { // 收起
            self.cellItems = self.dataList.prefix(WTTodayIndiceInfoView.defaultLoadCount).map({ data in
                return IndiceDailyInfoItem(data: data)
            })
        }
        self.tableView.snp.updateConstraints { make in
            make.height.equalTo(IndiceDailyInfoItem.cellHeight * CGFloat(self.cellItems.count))
        }
        self.tableView.reloadData()
    }
    
    @objc func moreBtnClockEvent() {
        self.isExpand = !self.isExpand
        let title: String = self.isExpand ? "收起" : "展开更多"
        moreBtn.setTitle(title, for: .normal)
        self.handleTableEvent(isExpand: self.isExpand)
        let fixedHeight: CGFloat = 10 + 30 + 40
        self.clickMoreClosure?(fixedHeight + CGFloat(self.cellItems.count) * IndiceDailyInfoItem.cellHeight)
    }
}

extension WTTodayIndiceInfoView: UITableViewDelegate, UITableViewDataSource {
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
        return cell ?? CCTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.cellItems[indexPath.row]
        return item.cellHeight
    }
}
