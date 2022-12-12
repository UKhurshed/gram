//
//  FloatingPanelUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 11.12.2022.
//

import UIKit

protocol FloationPanelUIViewDelegate: AnyObject {
    func searchTapped()
}

class FloatingPanelUIView: UIView {
    
    //search View's
    private let searchView = UIView()
    private let carIcon = UIImageView()
    private let whereWeGoing = UILabel()
    private let whiteLine = UILabel()
    private let arrowRight = UIImageView()
    private let collectionView = OrderHistoryCollectionView()
    
    weak var delegate: FloationPanelUIViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSearchView()
        initCarIcon()
        initWhereWeGoing()
        initWhiteLine()
        initArrowRight()
        initOrderHistoryCollectionView()
    }
    
    private func initSearchView() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.backgroundColor = UIColor.getColorByHex(rgbHexValue: 0xFF1C1C1C)
        searchView.layer.cornerRadius = 20
        
        searchView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchTapped(_:))))
        
        addSubview(searchView)
        searchView.snp.makeConstraints { makeSearch in
            makeSearch.top.equalToSuperview().offset(16)
            makeSearch.left.equalToSuperview().offset(16)
            makeSearch.right.equalToSuperview().offset(-16)
            makeSearch.height.equalTo(50)
        }
    }
    
     @objc private func searchTapped(_ sender: UIView) {
        delegate?.searchTapped()
    }
    
    private func initCarIcon() {
        carIcon.translatesAutoresizingMaskIntoConstraints = false
        carIcon.contentMode = .center
        carIcon.image = UIImage(named: "car")
        
        addSubview(carIcon)
        carIcon.snp.makeConstraints { makeCarIcon in
            makeCarIcon.top.equalTo(searchView.snp.top).offset(15)
            makeCarIcon.left.equalTo(searchView.snp.left).offset(20)
            makeCarIcon.height.equalTo(24)
            makeCarIcon.width.equalTo(37)
        }
    }
    
    private func initWhereWeGoing() {
        whereWeGoing.translatesAutoresizingMaskIntoConstraints = false
        whereWeGoing.text = R.string.localizable.whereWeGoing()
        whereWeGoing.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        whereWeGoing.textColor = .white
        
        addSubview(whereWeGoing)
        whereWeGoing.snp.makeConstraints { makeWhere in
            makeWhere.top.equalTo(searchView.snp.top).offset(15)
            makeWhere.left.equalTo(carIcon.snp.right).offset(15)
        }
    }
    
    private func initWhiteLine() {
        whiteLine.translatesAutoresizingMaskIntoConstraints = false
        whiteLine.backgroundColor = .white
        
        addSubview(whiteLine)
        whiteLine.snp.makeConstraints { makeWhiteLine in
            makeWhiteLine.top.equalTo(searchView.snp.top).offset(16)
            makeWhiteLine.left.equalTo(whereWeGoing.snp.right).offset(140)
            makeWhiteLine.height.equalTo(20)
            makeWhiteLine.width.equalTo(1)
        }
    }
    
    private func initArrowRight() {
        arrowRight.translatesAutoresizingMaskIntoConstraints = false
        arrowRight.image = UIImage(named: "arrow_right")
        
        addSubview(arrowRight)
        arrowRight.snp.makeConstraints { makeArrowRight in
            makeArrowRight.top.equalTo(searchView.snp.top).offset(17)
            makeArrowRight.left.equalTo(whiteLine.snp.right).offset(16)
        }
    }
    
    private func initOrderHistoryCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { makeCollection in
            makeCollection.top.equalTo(searchView.snp.bottom).offset(17)
            makeCollection.left.equalToSuperview().offset(16)
            makeCollection.right.equalToSuperview().offset(-16)
            makeCollection.height.equalTo(115)
        }
        let order = "item"
        collectionView.setupDataSource(orderHistory: [order, order, order, order, order])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
