//
//  SearchTableViewCell.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "searchTableViewCell"
    
    private let mainView = UIView()
    private let searchName = UILabel()
    private let street = UILabel()
    private let grayLine = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = UIColor.getColorByHex(rgbHexValue: 0xFFEEEEEE)
        initMainView()
        initSearchName()
        initStreet()
        initGrayLine()
    }
    
    private func initMainView() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainView)
        mainView.snp.makeConstraints { makeMainView in
            makeMainView.top.equalToSuperview()
            makeMainView.left.equalToSuperview()
            makeMainView.right.equalToSuperview()
            makeMainView.bottom.equalToSuperview()
            makeMainView.height.equalTo(64)
        }
    }
    
    private func initSearchName() {
        searchName.translatesAutoresizingMaskIntoConstraints = false
        searchName.textColor = UIColor.getColorByHex(rgbHexValue: 0xFF1C1C1C)
        searchName.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
        addSubview(searchName)
        searchName.snp.makeConstraints { makeSearchName in
            makeSearchName.top.equalTo(mainView.snp.top).offset(15)
            makeSearchName.left.equalTo(mainView.snp.left)
        }
    }
    
    private func initStreet() {
        street.translatesAutoresizingMaskIntoConstraints = false
        street.textColor = UIColor.getColorByHex(rgbHexValue: 0xFF989898)
        street.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        
        addSubview(street)
        street.snp.makeConstraints { makeStreet in
            makeStreet.top.equalTo(searchName.snp.bottom).offset(3)
            makeStreet.left.equalTo(mainView.snp.left)
        }
    }
    
    private func initGrayLine() {
        grayLine.translatesAutoresizingMaskIntoConstraints = false
        grayLine.backgroundColor = UIColor.getColorByHex(rgbHexValue: 0xFFD9D9D9)
        
        addSubview(grayLine)
        grayLine.snp.makeConstraints { makeGrayLine in
            makeGrayLine.left.equalTo(mainView.snp.left)
            makeGrayLine.right.equalTo(mainView.snp.right)
            makeGrayLine.bottom.equalTo(mainView.snp.bottom)
            makeGrayLine.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupData(searchName: String, street: String) {
        self.searchName.text = searchName
        self.street.text = street
    }
}
