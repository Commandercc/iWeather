//
//  WTLocationDetailPageViewController.swift
//  iweather
//
//  Created by zhengxu on 2023/1/16.
//

import Foundation

final class WTLocationDetailPageViewController: CCBaseViewController {
    private let nameLabel = UILabel(frame: .zero)
    private let addressLabel = UILabel(frame: .zero)
    private let addBtn = UIButton(frame: .zero)
    private let opreateView = UIView(frame: .zero)
    private let location: WTLocation
    
    init(loc: WTLocation) {
        self.location = loc
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubViews(views: [nameLabel, addressLabel, addBtn, opreateView])
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CGFloat.navBarHeight)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.greaterThanOrEqualToSuperview()
            make.right.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        addBtn.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        opreateView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(300)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        nameLabel.font = UIFont.Font(20)
        nameLabel.textColor = UIColor.black
        addressLabel.font = UIFont.Font(18)
        addressLabel.textColor = UIColor.gray
        addBtn.setTitle("添加到主页", for: .normal)
        addBtn.setTitleColor(UIColor.black, for: .normal)
        addBtn.backgroundColor = UIColor.xF4F4F4
        addBtn.addTarget(self, action: #selector(addToHome), for: .touchUpInside)
        addBtn.layer.cornerRadius = 10
        addBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        nameLabel.text = self.location.name
        addressLabel.text = self.location.address
        
        opreateView.isHidden = true
        let cancelBtn = UIButton(frame: .zero)
        let gotoHomeBtn = UIButton(frame: .zero)
        opreateView.addSubViews(views: [cancelBtn, gotoHomeBtn])
        cancelBtn.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        gotoHomeBtn.snp.makeConstraints { make in
            make.left.equalTo(cancelBtn.snp.right).offset(100)
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        cancelBtn.setTitle("取消添加", for: .normal)
        cancelBtn.setTitleColor(UIColor.black, for: .normal)
        cancelBtn.backgroundColor = UIColor.xF4F4F4
        cancelBtn.addTarget(self, action: #selector(cancelAdd), for: .touchUpInside)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        gotoHomeBtn.setTitle("去主页查看", for: .normal)
        gotoHomeBtn.setTitleColor(UIColor.black, for: .normal)
        gotoHomeBtn.backgroundColor = UIColor.xF4F4F4
        gotoHomeBtn.addTarget(self, action: #selector(gotoHome), for: .touchUpInside)
        gotoHomeBtn.layer.cornerRadius = 10
        gotoHomeBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    @objc private func addToHome() {
        WTLocationManager.shared.addNewLocation(loc: self.location)
        self.addBtn.isHidden = true
        self.opreateView.isHidden = false
    }
    
    @objc private func cancelAdd() {
        WTLocationManager.shared.removeTargetLocation(loc: location)
        self.opreateView.isHidden = true
        self.addBtn.isHidden = false
    }
    
    @objc private func gotoHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
