//
//  OrderHistoryCollectionView.swift
//  gram
//
//  Created by Khurshed Umarov on 11.12.2022.
//

import UIKit

class OrderHistoryCollectionView: UICollectionView {
    
    private var collectionViewData = [String]()
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionViewFlowLayout(layout: layout)
        register(OrderHistoryCollectionViewCell.self, forCellWithReuseIdentifier: OrderHistoryCollectionViewCell.identifier)
        backgroundColor = .white
        delegate = self
        dataSource = self
    }
    
    private func setupCollectionViewFlowLayout(layout: UICollectionViewFlowLayout) {
        layout.scrollDirection = .horizontal
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder) was occurred error")
    }
    
    func setupDataSource(orderHistory: [String]) {
        self.collectionViewData = orderHistory
        reloadData()
    }
}

extension OrderHistoryCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension OrderHistoryCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 115)
    }
}

extension OrderHistoryCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionViewData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OrderHistoryCollectionViewCell.identifier, for: indexPath) as! OrderHistoryCollectionViewCell
        cell.setupCell(data: item)
        print("item: \(cell)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewData.count
    }

}
