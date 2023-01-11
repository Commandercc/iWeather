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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(FeatureHoursInfoCell.self, forCellWithReuseIdentifier: "iweather.FeatureHoursInfoCell")
        collectionView?.backgroundColor = .clear
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false

        if let collectionView = collectionView {
            self.addSubview(collectionView)
            collectionView.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.centerY.equalToSuperview()
                make.height.equalTo(120)
            }
        }
    }
    
    func updateViews(hours: [Hourly]) {
        guard !hours.isEmpty else { return }
        self.cellItems = hours.map({ hour in
            let data = FeatureHoursInfoDataModel()
            data.fxTime = hour.fxTime
            data.temp = hour.temp
            data.icon = hour.icon
            data.windDir = hour.windDir
            data.windScale = hour.windScale
            data.text = hour.text
            return FeatureHoursInfoItem(data: data)
        })
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
