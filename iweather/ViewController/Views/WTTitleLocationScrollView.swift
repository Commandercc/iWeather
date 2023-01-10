//
//  WTTitleLocationScrollView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/7.
//

import Foundation
import UIKit

final class WTTitleLocationScrollView: UIView {
    
    private let addView = UIImageView(image: UIImage(named: "icon_add_white"))
    private let moreView = UIImageView(image: UIImage(named: "icon_more_vertical_white"))
    private let location = UILabel(frame: .zero)
    let pageControl = UIPageControl(frame: .zero)
    var localTitles: [String] = [] {
        didSet {
            self.pageControl.numberOfPages = localTitles.count
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
        self.addSubViews(views: [addView, location, moreView, pageControl])
        addView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        location.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(addView.snp.right).offset(10)
            make.centerX.equalToSuperview()
            make.right.greaterThanOrEqualTo(moreView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
        moreView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerY.equalToSuperview()
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(location.snp.bottom)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
        }
        
        location.text = "朝阳区 左家庄西街"
        location.font = UIFont.BoldFont(18)
        location.textAlignment = .center
        location.lineBreakMode = .byTruncatingTail
        location.textColor = UIColor.white
        
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.isEnabled = false
    }
}
