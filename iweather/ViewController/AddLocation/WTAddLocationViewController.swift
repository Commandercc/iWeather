//
//  WTAddLocationViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/14.
//

import Foundation

final class WTAddLocationViewController: CCBaseViewController {
    private let searchController = UISearchController()
    private let tableView = UITableView(frame: .zero)
    private var cellItems: [CCTableViewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.navBarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LocationSearchResultCell.self, forCellReuseIdentifier: "iweather.LocationSearchResultCell")
        
        searchController.searchResultsUpdater = self
        self.tableView.tableHeaderView = searchController.searchBar
    }
}

extension WTAddLocationViewController: UITableViewDelegate, UITableViewDataSource {
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

extension WTAddLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let input = searchController.searchBar.text, !input.isEmpty {
            WTLocationManager.shared.locationSearchService(keyword: input)
            WTLocationManager.shared.searchLocationCallBack = { [weak self] (locations, error) in
                if let locations = locations {
                    self?.cellItems = locations.map({ loc in
                        let item = LocationSearchResultItem(location: loc)
                        return item
                    })
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
