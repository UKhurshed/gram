//
//  SearchPanelUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import UIKit

protocol SearchPanelUIViewDelegate: AnyObject {
    func textChanging(text: String)
}

class SearchPanelUIView: UIView {
    
    private let searchTextField = UITextField()
    private let imageView = UIImageView()
    private let indicator = UIActivityIndicatorView()
    private let tableView = UITableView()
    private let enterAddress = UILabel()
    
    weak var delegate: SearchPanelUIViewDelegate?
    
    private var viewModel = [SearchResultViewModel]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.getColorByHex(rgbHexValue: 0xFFEEEEEE)
        initSearchTextField()
        searchTextField.delegate = self
        initIndicator()
        initTableView()
        initEnterAddress()
    }
    
    private func initSearchTextField() {
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        let padding = UIView(frame: CGRectMake(0, 0, 15, self.searchTextField.frame.height))
        searchTextField.leftView = padding
        searchTextField.leftViewMode = .always
        
        imageView.frame = CGRect(x: 15, y: 23, width: 17, height: 17)
        imageView.image = UIImage(named: "search-field")
       
        searchTextField.addSubview(imageView)
        let leftView = UIView.init(frame: CGRectMake(24, 50, 45, 0))
        searchTextField.leftView = leftView
        searchTextField.layer.borderWidth = 1.0
        searchTextField.layer.borderColor = CGColor.getColorByHexCgColor(rgbHexValue: 0xFFFFFFFF)
        searchTextField.layer.cornerRadius = 15
        searchTextField.backgroundColor = .white
        searchTextField.placeholder = "Адрес"
        setRightView()
        
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { makeSearchField in
            makeSearchField.top.equalToSuperview().offset(17)
            makeSearchField.left.equalToSuperview().offset(8)
            makeSearchField.right.equalToSuperview().offset(-8)
            makeSearchField.height.equalTo(61)
        }
    }
    
    private func setRightView() {
        searchTextField.rightViewMode = .always
        let mapLabel = UILabel()
        mapLabel.text = "Карта"
        mapLabel.font = UIFont.systemFont(ofSize: 14)
        mapLabel.textColor = UIColor.getColorByHex(rgbHexValue: 0xFF989898)
        mapLabel.frame = CGRect(x: 300, y: 20, width: 50, height: 20)
        searchTextField.addSubview(mapLabel)
    }
    
    private func initIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        
        addSubview(indicator)
        indicator.snp.makeConstraints { makeIndicator in
            makeIndicator.centerX.equalToSuperview()
            makeIndicator.centerY.equalToSuperview()
        }
    }
    
    private func initTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.backgroundColor = UIColor.getColorByHex(rgbHexValue: 0xFFEEEEEE)
        tableView.dataSource = self
        
        addSubview(tableView)
        tableView.snp.makeConstraints { makeTableView in
            makeTableView.top.equalTo(searchTextField.snp.bottom).offset(20)
            makeTableView.left.equalToSuperview().offset(50)
            makeTableView.right.equalToSuperview()
            makeTableView.bottom.equalToSuperview()
        }
    }
    
    private func initEnterAddress() {
        enterAddress.translatesAutoresizingMaskIntoConstraints = false
        enterAddress.text = "Введите место или адрес"
        enterAddress.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        enterAddress.textColor = UIColor.getColorByHex(rgbHexValue: 0xFF989898)
        enterAddress.isHidden = false
        
        addSubview(enterAddress)
        enterAddress.snp.makeConstraints { makeEnterAddress in
            makeEnterAddress.top.equalTo(searchTextField.snp.bottom).offset(22)
            makeEnterAddress.left.equalToSuperview().offset(100)
            makeEnterAddress.right.equalToSuperview().offset(-100)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func startAnimatingIndicator() {
        DispatchQueue.main.async {
            self.indicator.startAnimating()
        }
    }
    
    public func stopAnimatingIndicator() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    public func showError() {
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    public func emptyTableView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.enterAddress.isHidden = false
        }
    }
    
    public func successCase(result: [SearchResultViewModel]) {
        print("result: \(result)")
        if result.isEmpty {
            emptyTableView()
        } else {
            DispatchQueue.main.async {
                self.viewModel = result
                self.tableView.isHidden = false
                self.enterAddress.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
}


extension SearchPanelUIView: UITextFieldDelegate {

    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("text: \(String(describing: textField.text))")
        delegate?.textChanging(text: textField.text ?? "")
    }
}

extension SearchPanelUIView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.setupData(searchName: item.name, street: item.street ?? "Улица")
        print("cell: \(cell)")
        return cell
    }
}
