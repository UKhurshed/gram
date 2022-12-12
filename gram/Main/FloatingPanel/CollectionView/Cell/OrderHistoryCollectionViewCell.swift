//
//  OrderHistoryCollectionViewCell.swift
//  gram
//
//  Created by Khurshed Umarov on 11.12.2022.
//

import UIKit

class OrderHistoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "orderHistoryCollectionViewCell"
    
    private let orderHistory = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .blue
        initImage()
    }
    
    private func initImage() {
        orderHistory.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(orderHistory)
        orderHistory.snp.makeConstraints { makeOrderHistory in
            makeOrderHistory.top.equalToSuperview()
            makeOrderHistory.left.equalToSuperview()
            makeOrderHistory.right.equalToSuperview()
            makeOrderHistory.bottom.equalToSuperview()
            makeOrderHistory.height.equalTo(115)
            makeOrderHistory.width.equalTo(115)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("coder: NSCoder was occurred")
    }
    
    func setupCell(data: String) {
        orderHistory.image = UIImage(named: data)
    }
}
