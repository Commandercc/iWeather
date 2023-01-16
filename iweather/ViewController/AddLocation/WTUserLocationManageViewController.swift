//
//  WTUserLocationManageViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/15.
//

import Foundation

final class WTUserLocationManageViewController: CCBaseViewController {
    private let tableView = UITableView(frame: .zero)
    private var cellItems: [CCTableViewItem] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.cellItems.removeAll()
        WTLocationManager.shared.cachedLocations.forEach { location in
            let item = LocationAndWeatherItem(location: location, temp: "-33°", wDesc: "晴")
            self.cellItems.append(item)
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for _ in 1 ... 20 {
//            let location = WTLocation()
//            location.name = "左家庄北里 朝阳区左家庄北里 朝阳区左家庄北里 朝阳区左家庄北里 朝阳区左家庄北里 朝阳区左家庄北里 朝阳区"
//            let item = LocationAndWeatherItem(location: location, temp: "-33°", wDesc: "晴")
//            self.cellItems.append(item)
//        }
        self.setupViews()
    }
    
    private func setupViews() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: 60 + 40 + 10))
        let titleLabel = UILabel(frame: .zero)
        headerView.addSubview(titleLabel)
        titleLabel.frame = CGRect(x: 20, y: 0, width: CGFloat.screenWidth - 40, height: 60)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.BoldFont(25)
        titleLabel.text = "地点管理"
        let searchView = UIView(frame: CGRect(x: 20, y: 60, width: CGFloat.screenWidth - 40, height: 40))
        searchView.layer.cornerRadius = 20
        searchView.backgroundColor = UIColor.xF4F4F4
        let icon = UIImageView(image: UIImage(named: "icon_search_gray"))
        icon.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        searchView.addSubview(icon)
        let placeholder = UILabel(frame: CGRect(x: 10 + 20 + 5, y: 10, width: 150, height: 20))
        placeholder.text = "搜索更多地点的天气数据"
        placeholder.font = UIFont.Font(13)
        placeholder.textColor = UIColor.x707070
        placeholder.textAlignment = .left
        searchView.addSubview(placeholder)
        headerView.addSubview(searchView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addOtherCity)) // 去添加其他地点
        searchView.addGestureRecognizer(tapGesture)
        
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
        tableView.tableHeaderView = headerView
        tableView.showsVerticalScrollIndicator = false
        tableView.register(LocationAndWeatherCell.self, forCellReuseIdentifier: "iweather.LocationAndWeatherCell")
        tableView.separatorStyle = .none
        //tableView.reloadData()
    }
    
    @objc private func addOtherCity() {
        let vc = WTAddLocationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension WTUserLocationManageViewController: UITableViewDelegate, UITableViewDataSource {
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

extension WTUserLocationManageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 {
            self.navigationItem.title = "地点管理"
        } else {
            self.navigationItem.title = ""
        }
    }
}
