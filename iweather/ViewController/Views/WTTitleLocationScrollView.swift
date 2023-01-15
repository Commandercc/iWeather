//
//  WTTitleLocationScrollView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

import Foundation
import UIKit

final class WTTitleLocationScrollView: UIView {
    var addCallback: (() -> Void)?
    private let addView = UIImageView(image: UIImage(named: "icon_add_black"))
    private let moreView = UIImageView(image: UIImage(named: "icon_more_vertical_black"))
    let location = UILabel(frame: .zero)
    let pageControl = UIPageControl(frame: .zero)
    var localTitles: [String] = [] {
        didSet {
            self.pageControl.numberOfPages = localTitles.count
            self.pageControl.isHidden = localTitles.count <= 1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = WTBaseData.mainBackColor
        self.addSubViews(views: [addView, location, moreView, pageControl])
        addView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.statusBarHeight + 10)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        location.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(addView.snp.right).offset(10)
            make.centerX.equalToSuperview()
            make.right.greaterThanOrEqualTo(moreView.snp.left).offset(-10)
            make.centerY.equalTo(addView.snp.centerY)
        }
        moreView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalTo(addView.snp.centerY)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        let lineView = UIView(frame: .zero)
        self.addSubview(lineView)
        lineView.backgroundColor = UIColor.lightGray
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        location.text = ""
        location.font = UIFont.BoldFont(18)
        location.textAlignment = .center
        location.lineBreakMode = .byTruncatingTail
        location.textColor = UIColor.black
        
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.isEnabled = false
        
        addView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addLocation))
        addView.addGestureRecognizer(gesture)
    }
    
    @objc func addLocation() {
//        let vc = WTAddLocationViewController()
//        if let nav = UIApplication.shared.curKeyWindow?. {
//            nav.pushViewController(vc, animated: true)
//        }
        self.addCallback?()
    }
}
