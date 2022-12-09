//
//  RegisterViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit

protocol RegisterDisplayLogic: AnyObject {
    func presentingRegister(viewModel: RegisterViewModel)
    func startLoading()
    func finishLoading()
    func showError(errorDescription: String)
}

class RegisterViewController: UIViewController {
    
    private var registerView: RegisterUIView {
        self.view as! RegisterUIView
    }
    
    var interactor: RegisterBusinessLogic?
    
    override func loadView() {
        view = RegisterUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.delegate = self
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    
    func presentingRegister(viewModel: RegisterViewModel) {
        print("load presents from interactor: \(viewModel)")
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.registerView.startAnimatingIndicator()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.registerView.stopAnimatingIndicator()
        }
    }
    
    func showError(errorDescription: String) {
        print("error: \(errorDescription)")
        DispatchQueue.main.async {
            self.registerView.showError()
            let alert  = UIAlertController(title: R.string.localizable.errorLabel(), message: errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
}

extension RegisterViewController: NextBtnPressedDelegate {
    func nextBtnAction(phoneNumber: String) {
        print("Phone: \(phoneNumber)")
        interactor?.sendPhoneNumber(reguest: RegisterRequest(phoneNumber: phoneNumber))
    }
}
