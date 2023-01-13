//
//  WTModuleBaseView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/13.
//

import Foundation
import UIKit

class WTModuleBaseView: UIView {
    let topTilte = UILabel(frame: .zero) // 标题

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(topTilte)
        topTilte.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        topTilte.font = UIFont.Font(15)
        topTilte.textColor = WTBaseData.mainTitleColor
        topTilte.textAlignment = .left
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
