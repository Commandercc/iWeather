//
//  CCLoadingView.swift
//  thunder
//
//  Created by zhengxu on 2022/2/26.
//

import Foundation
import UIKit
import SnapKit

// MARK: CCActivityLoadingView
class CCActivityLoadingView: UIView {
    private weak var desView: UIView? // 目标view，在该view上显示
    private let activityView = UIActivityIndicatorView(style: .medium)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.alpha(0.6)
        self.isUserInteractionEnabled = true // 拦住事件，不让点击遮罩下的内容
        self.addSubview(activityView)
        activityView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        activityView.color = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoding(_ onView: UIView) {
        self.desView = onView
        onView.addSubview(self)
        self.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.activityView.startAnimating()
    }
    
    func stopLoading() {
        self.removeFromSuperview()
        self.activityView.stopAnimating()
    }
}


