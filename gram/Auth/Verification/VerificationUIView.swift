//
//  VerificationUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import UIKit

protocol VerifyUIViewDelegate: AnyObject {
    func sentCode(code: String)
}

class VerificationUIView: UIView, UITextFieldDelegate {
    
    private let enterCodeLabel = UILabel()
    private let firstField = UITextField()
    private let secondField = UITextField()
    private let thirdField = UITextField()
    private let fourthField = UITextField()
    private let fieldStackView = UIStackView()
    private let nextButton = UIButton()
    private let indicator = UIActivityIndicatorView()
    
    private var smsCode = [String]()
    
    weak var delegate: VerifyUIViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initEnterCodeLabel()
        initFirstField()
        initSecondField()
        initThirdField()
        initFourthField()
        initStackOfFields()
        initNextButton()
        
        firstField.delegate = self
        secondField.delegate = self
        thirdField.delegate = self
        fourthField.delegate = self
        
        firstField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        secondField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        thirdField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        fourthField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        firstField.becomeFirstResponder()
    }
    
    private func initEnterCodeLabel() {
        enterCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        enterCodeLabel.text = R.string.localizable.enterCodeLabel() + " +99292*****44"
        enterCodeLabel.font = UIFont.systemFont(ofSize: 18)
        enterCodeLabel.numberOfLines = 2
        
        addSubview(enterCodeLabel)
        enterCodeLabel.snp.makeConstraints { makeEnterCode in
            makeEnterCode.top.equalToSuperview().offset(120)
            makeEnterCode.left.equalToSuperview().offset(40)
            makeEnterCode.right.equalToSuperview().offset(-40)
        }
    }
    
    private func initFirstField() {
        firstField.translatesAutoresizingMaskIntoConstraints = false
        firstField.placeholder = "*"
        firstField.backgroundColor = .systemGray5
        firstField.layer.cornerRadius = 10
        firstField.textAlignment = .center
        firstField.keyboardType = .decimalPad
        
        firstField.snp.makeConstraints { makeFirstField in
            makeFirstField.width.equalTo(48)
        }
    }
    
    private func initSecondField() {
        secondField.translatesAutoresizingMaskIntoConstraints = false
        secondField.placeholder = "*"
        secondField.backgroundColor = .systemGray5
        secondField.layer.cornerRadius = 10
        secondField.textAlignment = .center
        secondField.keyboardType = .decimalPad
        
        secondField.snp.makeConstraints { makeSecondField in
            makeSecondField.width.equalTo(48)
        }
    }
    
    private func initThirdField() {
        thirdField.translatesAutoresizingMaskIntoConstraints = false
        thirdField.placeholder = "*"
        thirdField.backgroundColor = .systemGray5
        thirdField.layer.cornerRadius = 10
        thirdField.textAlignment = .center
        thirdField.keyboardType = .decimalPad
        
        thirdField.snp.makeConstraints { makeThirdField in
            makeThirdField.width.equalTo(48)
        }
    }
    
    private func initFourthField(){
        fourthField.translatesAutoresizingMaskIntoConstraints = false
        fourthField.placeholder = "*"
        fourthField.backgroundColor = .systemGray5
        fourthField.layer.cornerRadius = 10
        fourthField.textAlignment = .center
        fourthField.keyboardType = .decimalPad
        
        fourthField.snp.makeConstraints { makeFourthField in
            makeFourthField.width.equalTo(48)
        }
    }
    
    private func initStackOfFields() {
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.axis = .horizontal
        fieldStackView.distribution = .equalSpacing
        fieldStackView.addArrangedSubview(firstField)
        fieldStackView.addArrangedSubview(secondField)
        fieldStackView.addArrangedSubview(thirdField)
        fieldStackView.addArrangedSubview(fourthField)
        
        addSubview(fieldStackView)
        fieldStackView.snp.makeConstraints { makeStackOfFields in
            makeStackOfFields.top.equalTo(enterCodeLabel.snp.bottom).offset(40)
            makeStackOfFields.left.equalToSuperview().offset(45)
            makeStackOfFields.right.equalToSuperview().offset(-45)
            makeStackOfFields.height.equalTo(52)
        }
    }
    
    private func initNextButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .black
        nextButton.setTitle(R.string.localizable.nextBtn(), for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.layer.cornerRadius = 4
        nextButton.addTarget(self, action: #selector(sentСodeBtn), for: .touchUpInside)
    
        addSubview(nextButton)
        nextButton.snp.makeConstraints { makeNextBtn in
            makeNextBtn.top.equalTo(fieldStackView.snp.bottom).offset(40)
            makeNextBtn.left.equalToSuperview().offset(25)
            makeNextBtn.right.equalToSuperview().offset(-25)
            makeNextBtn.height.equalTo(45)
        }
    }
    
    @objc private func sentСodeBtn() {
        if(smsCode.count == 4){
            delegate?.sentCode(code: smsCode.joined())
            print("Joined: \(smsCode.joined())")
        }else{
            print("Code: \(smsCode)")
        }
    }
    
    @objc private func textFieldDidChange(textField: UITextField){
        if let text = textField.text{
            if text.count == 1 {
                switch textField{
                case firstField:
                    smsCode.append(text)
                    secondField.becomeFirstResponder()
                case secondField:
                    smsCode.append(text)
                    thirdField.becomeFirstResponder()
                case thirdField:
                    smsCode.append(text)
                    fourthField.becomeFirstResponder()
                case fourthField:
                    smsCode.append(text)
                    fourthField.resignFirstResponder()
                    self.dismissKeyboard()
                default:
                    break
                }
            }
            
            if text.count == 0 {
                switch textField{
                case firstField:
                    smsCode.remove(object: text)
                    firstField.becomeFirstResponder()
                case secondField:
                    smsCode.remove(object: text)
                    firstField.becomeFirstResponder()
                case thirdField:
                    smsCode.remove(object: text)
                    secondField.becomeFirstResponder()
                case fourthField:
                    smsCode.remove(object: text)
                    thirdField.becomeFirstResponder()
                default:
                    break
                }
            }
        }
    }
    
    private func dismissKeyboard(){
        self.endEditing(true)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func clearState(){
        smsCode.removeAll()
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
}

extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}
