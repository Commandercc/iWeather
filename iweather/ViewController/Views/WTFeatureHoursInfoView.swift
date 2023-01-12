//
//  WTFeatureHoursInfoView.swift
//  iweather
//
//  Created by zhengxu on 2023/1/11.
//

import Foundation
import UIKit

final class WTFeatureHoursInfoView: UIView {
    private var collectionView: UICollectionView?
    private var cellItems: [CCCollectionViewItem] = []
    private let topTilte = UILabel(frame: .zero) // 标题

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = WTBaseData.moduleBackColor
        self.addSubview(topTilte)
        topTilte.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.lessThanOrEqualToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        topTilte.font = UIFont.Font(15)
        topTilte.textColor = WTBaseData.mainTitleColor
        topTilte.textAlignment = .left
        topTilte.text = "未来24小时天气"
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 80, height: 125)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(FeatureHoursInfoCell.self, forCellWithReuseIdentifier: "iweather.FeatureHoursInfoCell")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false

        if let collectionView = collectionView {
            self.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.top.equalTo(topTilte.snp.bottom)
                make.left.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-10)
                make.height.equalTo(125)
            }
        }
    }
    
    func updateViews(dataList: [FeatureHoursInfoDataModel]) {
        guard !dataList.isEmpty else { return }
        self.cellItems = dataList.map({ FeatureHoursInfoItem(data: $0) })
        self.collectionView?.reloadData()
    }
}

extension WTFeatureHoursInfoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.cellItems[indexPath.row]
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.cellClassName, for: indexPath) as? CCCollectionViewCell
        if cell == nil {
            cell = CCObjectGenerateFromClassString.createObjectGenerate(fromClassString: item.cellClassName) as? CCCollectionViewCell
        }
        cell?.item = item
        return cell ?? CCCollectionViewCell()
    }
}
