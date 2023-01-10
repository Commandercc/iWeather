//
//  WTNowInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/10.
//

import Foundation
import UIKit

final class WTNowInfoView: UIView {
    private let tempLabel = UILabel(frame: .zero) // 温度
    private let weatherDesc = UILabel(frame: .zero) // 天气描述
    private let degreeImg = UIImageView(image: UIImage(named: "icon_temp_degree"))
    private let tempView = UIView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.addSubViews(views: [tempView, weatherDesc])
        tempView.addSubViews(views: [tempLabel, degreeImg])
        tempView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        tempLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        degreeImg.snp.makeConstraints { make in
            make.left.equalTo(tempLabel.snp.right).offset(5)
            make.top.equalTo(tempLabel.snp.top)
            make.right.equalToSuperview()
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        weatherDesc.snp.makeConstraints { make in
            make.top.equalTo(tempView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        tempLabel.font = UIFont.BoldFont(85)
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .left
        
        weatherDesc.font = UIFont.BoldFont(20)
        weatherDesc.textColor = UIColor.white
        weatherDesc.textAlignment = .center
        
        tempView.isHidden = true
    }
    
    func updateValues(temp: String, desc: String) {
        guard !temp.isEmpty && !desc.isEmpty else { return }
        tempView.isHidden = false
        tempLabel.text = temp
        weatherDesc.text = desc
    }
}
