//
//  VerificationViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import UIKit

class VerificationViewController: UIViewController {
    
    private var verifyUIView: VerificationUIView {
        self.view as! VerificationUIView
    }
    
    var presenter: VerifyViewInput!
    
    var clienrID: String = ""
    
    override func loadView() {
        view = VerificationUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        verifyUIView.delegate = self
        setup()
    }
    
    private func setup() {
        let viewController = self
        let facade = URLSessionFacade()
        let service = VerificationServiceImpl(urlSession: facade)
        let interactor = VerificationInteractor(service: service)
        let presenter = VerificationPresenter()
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.viewController = viewController
    }

}

extension VerificationViewController: VerifyDisplayLogic {
    func success(viewModel: VerifyViewModel) {
        print("viewModel: \(viewModel)")
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.verifyUIView.startAnimatingIndicator()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.verifyUIView.stopAnimatingIndicator()
        }
    }
    
    func showError(errorDescription: String) {
        print("error: \(errorDescription)")
        DispatchQueue.main.async {
            self.verifyUIView.showError()
            let alert  = UIAlertController(title: R.string.localizable.errorLabel(), message: errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension VerificationViewController: VerifyUIViewDelegate {
    func sentCode(code: String) {
        let clientRegisterID = UserDefaults.standard.string(forKey: "clientRegisterID") ?? ""
        presenter.verifyByCode(request: VerifyRequest(clientRegisterID: clienrID, smsCode: code))
    }
}
