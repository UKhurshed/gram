//
//  RegisterViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private var registerView: RegisterUIView {
        self.view as! RegisterUIView
    }
    
    var presenterInput: RegisterViewInput!
    
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
        let facade = URLSessionFacade()
        let service = RegisterServiceImpl(urlSession: facade)
        let interactor = RegisterInteractor(service: service)
        let presenter = RegisterPresenter()
        viewController.presenterInput = presenter
        presenter.interactor = interactor
        presenter.viewController = viewController
    }
}

extension RegisterViewController: RegisterDisplayLogic {
    
    func success(viewModel: RegisterViewModel) {
        print("load presents from interactor: \(viewModel)")
        DispatchQueue.main.async {
            let vc = VerificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
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
        presenterInput.registerByPhoneNumber(request: RegisterRequest(phoneNumber: phoneNumber))
    }
}
