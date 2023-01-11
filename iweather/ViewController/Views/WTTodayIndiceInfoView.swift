//
//  WTTodayIndiceInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class WTTodayIndiceInfoView: UIView {
    static let TodayIndiceCellHeight: CGFloat = 40
    private let tableView = UITableView(frame: .zero)
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
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(0)
        }
        
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
    }
    
    func updateViews(indiceList: [IndicesDaily]) {
        guard !indiceList.isEmpty else { return }
        self.cellItems = indiceList.map({ indice in
            let data = IndiceDailyInfoDataModel()
            data.name = indice.name
            data.text = indice.text
            data.category = indice.category
            data.date = indice.date
            data.level = indice.level
            data.type = indice.type
            return IndiceDailyInfoItem(data: data)
        })
        let tableHeight: CGFloat = self.cellItems.count > 5 ? (WTTodayIndiceInfoView.TodayIndiceCellHeight * 5.5) : (WTTodayIndiceInfoView.TodayIndiceCellHeight * CGFloat(self.cellItems.count))
        self.tableView.snp.updateConstraints { make in
            make.height.equalTo(tableHeight)
        }
        self.tableView.reloadData()
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
        cell?.backgroundView?.backgroundColor = UIColor.clear
        cell?.backgroundColor = UIColor.clear
        return cell ?? CCTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.cellItems[indexPath.row]
        return item.cellHeight
    }
}
