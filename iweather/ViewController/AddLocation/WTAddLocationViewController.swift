//
//  WTAddLocationViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/14.
//

import Foundation

final class WTAddLocationViewController: CCBaseViewController {
    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero)
    private var cellItems: [CCTableViewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(searchBar)
        self.view.addSubview(tableView)
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.navBarHeight)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LocationSearchResultCell.self, forCellReuseIdentifier: "iweather.LocationSearchResultCell")
          
        searchBar.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: 44)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "搜索其它地点"
        searchBar.layer.borderWidth = 0
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
            cancelButton.setTitle("取消", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("log log touche")
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = self.cellItems[indexPath.row] as? LocationSearchResultItem {
            let vc = WTLocationDetailPageViewController(loc: item.location)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension WTAddLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            WTLocationManager.shared.locationSearchService(keyword: searchText)
            WTLocationManager.shared.searchLocationCallBack = { [weak self] (locations, error) in
                if let locations = locations {
                    self?.cellItems = locations.map({ loc in
                        let item = LocationSearchResultItem(location: loc)
                        return item
                    })
                    self?.tableView.reloadData()
                }
            }
        } else {
            self.cellItems = []
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension WTAddLocationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
