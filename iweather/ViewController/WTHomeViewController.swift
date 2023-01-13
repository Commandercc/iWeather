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
    private var viewControllers: [WTDetailPageListViewController] = []
    private var currentIndex: Int = 0
    private var viewModel = WTHomeViewModel()
    private var locations: [WTLocation] {
        return WTLocationManager.shared.cachedLocations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.createViewControllers()
        if self.viewControllers.count > 0 {
            // 加载首屏天气信息
           //self.viewControllers.first?.loadDetailWeatherData()
        }
    }
    
    private func setupViews() {
        self.view.addSubview(scrollView)
        self.view.addSubview(locationView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: CGFloat.screenHeight)
        locationView.frame = CGRect(x: 0, y: 0, width: CGFloat.screenWidth, height: WTHomeViewController.TopHeight)
        if self.locations.isEmpty {
            self.view.makeToast("正在为您获取当前位置信息")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                WTLocationManager.shared.confirmLocationService { [weak self] (location: WTLocation?, error: Error?) in
                    guard let self = self, let loc = location else { return }
                    do {
                        let data = try JSONEncoder().encode([loc])
                        UserDefaults.standard.set(data, forKey: WTLocationManager.kToSaveLocations)
                    } catch {
                        print("error")
                    }
                    
                    self.setupLocationView(title: loc.name)
                    self.createViewControllers()
                }
            }
        } else {
            self.setupLocationView(title: self.locations.first?.name ?? "")
        }
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


