//
//  RegisterUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit
import SnapKit

protocol NextBtnPressedDelegate: AnyObject {
    func nextBtnAction(phoneNumber: String)
}

class RegisterUIView: UIView {
    
    private let enterPhoneNumberLabel = UILabel()
    private let phoneTextField = UITextField()
    private let nextButton = UIButton()
    private let indicator = UIActivityIndicatorView()
    
    private let maxNumCount = 12
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]")
    
    weak var delegate: NextBtnPressedDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initPhoneNumberLabel()
        initPhoneTextField()
        initNextButton()
        initIndicator()
    }
    
    private func initPhoneNumberLabel() {
        enterPhoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        enterPhoneNumberLabel.text = R.string.localizable.enterPhoneNumber()
        enterPhoneNumberLabel.font = UIFont.systemFont(ofSize: 20)
        
        addSubview(enterPhoneNumberLabel)
        enterPhoneNumberLabel.snp.makeConstraints { makePhoneNumLabel in
            makePhoneNumLabel.top.equalToSuperview().offset(120)
            makePhoneNumLabel.centerX.equalToSuperview()
        }
    }
    
    private func initPhoneTextField() {
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.keyboardType = .numberPad
        let padding = UIView(frame: CGRectMake(0, 0, 15, self.phoneTextField.frame.height))
        phoneTextField.leftView = padding
        phoneTextField.leftViewMode = .always
        phoneTextField.layer.borderWidth = 1.0
        phoneTextField.layer.cornerRadius = 8
        phoneTextField.becomeFirstResponder()
        phoneTextField.delegate = self
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { makePhoneField in
            makePhoneField.top.equalTo(enterPhoneNumberLabel.snp.bottom).offset(50)
            makePhoneField.left.equalToSuperview().offset(25)
            makePhoneField.right.equalToSuperview().offset(-25)
            makePhoneField.height.equalTo(50)
        }
    }
    
    private func initNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .black
        nextButton.setTitle(R.string.localizable.nextBtn(), for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 4
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    
        addSubview(nextButton)
        nextButton.snp.makeConstraints { makeNextBtn in
            makeNextBtn.top.equalTo(phoneTextField.snp.bottom).offset(30)
            makeNextBtn.left.equalToSuperview().offset(25)
            makeNextBtn.right.equalToSuperview().offset(-25)
            makeNextBtn.height.equalTo(45)
        }
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
    
    @objc private func nextPressed() {
        let range = NSString(string: phoneTextField.text ?? "").range(of: phoneTextField.text ?? "")
        let phoneNumber = regex.stringByReplacingMatches(in: phoneTextField.text ?? "", range: range, withTemplate: "")
        print("Number: \(phoneNumber)")
        delegate?.nextBtnAction(phoneNumber: phoneNumber)
    }
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        
        guard !(phoneNumber.count < 2) else { return "+992" }
        
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, range: range, withTemplate: "")
        
        if number.count > maxNumCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
            let pattern = "(\\d{3})(\\d{2})(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "($1) $2 $3 $4", options: .regularExpression, range: regRange)
        
        return "+" + number
    }
    
    public func startAnimatingIndicator() {
        indicator.startAnimating()
    }
    
    public func stopAnimatingIndicator() {
        indicator.stopAnimating()
    }
    
    public func showError() {
        indicator.stopAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegisterUIView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (textField.text ?? "") + string
        textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = R.string.localizable.tjCode()
    }
}
