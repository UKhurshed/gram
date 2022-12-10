//
//  VerificationPresenter.swift
//  gram
//
//  Created by Khurshed Umarov on 09.12.2022.
//

import Foundation

protocol VerifyViewInput: AnyObject {
    func verifyByCode(request: VerifyRequest)
}

protocol VerifyDisplayLogic: AnyObject {
    func success(viewModel: VerifyViewModel)
    func startLoading()
    func finishLoading()
    func showError(errorDescription: String)
}

class VerificationPresenter: VerifyViewInput {
    
    weak var viewController: VerifyDisplayLogic?
    var interactor: VerifyBusinessLogic!
    
    func verifyByCode(request: VerifyRequest) {
        Task {
            do {
                viewController?.startLoading()
                let verifyResponse = try await interactor.verifyByCode(request: request)
                viewController?.finishLoading()
                let result = verifyResponse.result
                viewController?.success(viewModel: VerifyViewModel(accessToken: result.accessToken, tokenType: result.tokenType, expiresAt: result.expiresAt))
            } catch {
                viewController?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
    
}
