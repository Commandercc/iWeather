//
//  WTHomeViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

import Foundation
import UIKit
import Toast_Swift

final class WTHomeViewController: CCBaseViewController {
    static let TopHeight: CGFloat = 55 + CGFloat.statusBarHeight
    private let locationView = WTTitleLocationScrollView(frame: .zero)
    private let scrollView = UIScrollView(frame: .zero)
    private var loadingView = CCActivityLoadingView()
    private var viewControllers: [WTDetailPageListViewController] = []
    private var currentIndex: Int = 0
    private var viewModel = WTHomeViewModel()
    private var locations: [WTLocation] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewEvent()
        
        locationView.addCallback = { [weak self] in
            let vc = WTUserLocationManageViewController()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        self.view.addSubview(locationView)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight)
        locationView.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: WTHomeViewController.TopHeight)
    }
    
    private func setupLocationView(title: String) {
        locationView.localTitles = self.locations.map({ $0.name })
        locationView.location.text = title
    }
    
    private func createViewControllers() {
        self.scrollView.removeAllSubViews()
        self.viewControllers.removeAll()
        self.locations.enumerated().forEach { (i, loc) in
            let vc = WTDetailPageListViewController(locationId: "\(loc.location.longitude),\(loc.location.latitude)")
            self.viewControllers.append(vc)
            self.scrollView.addSubview(vc.view)
            vc.view.frame = CGRect(x: CGFloat.screenWidth * CGFloat(i), y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight)
        }
        self.scrollView.contentSize = CGSize(width: CGFloat.screenWidth * CGFloat(self.viewControllers.count), height: 0)
        
        if self.viewControllers.count > 0 {
            // 加载首屏天气信息
           self.viewControllers.first?.loadDetailWeatherData()
        }
    }
    
    private func bindViewEvent() {
        self.locations = WTLocationManager.shared.cachedLocations

        // 默认首屏展示用户当前位置的天气信息
        self.loadingView.startLoding(self.view)
        WTLocationManager.shared.confirmLocationService { [weak self] (location: WTLocation?, error: Error?) in
            self?.loadingView.stopLoading()
            guard let self = self else {
                // 这里补充失败的逻辑
                return
            }
            if let loc = location {
                self.locations.insert(loc, at: 0)
                self.setupLocationView(title: loc.name)
                self.createViewControllers()
            } else {
                print("log log APP启动首次定位失败")
            }
        }
    }
}

extension WTHomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(floor((scrollView.contentOffset.x - scrollView.frame.size.width / 2)) / scrollView.frame.size.width + 1)
        if pageIndex >= 0 && pageIndex < self.viewControllers.count && pageIndex != self.currentIndex {
            self.locationView.pageControl.currentPage = pageIndex
            self.currentIndex = pageIndex
            //self.viewControllers[self.currentIndex].loadDetailWeatherData()
        }
    }
}


