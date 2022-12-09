//
//  RegisterPresenter.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import Foundation

protocol RegisterViewInput: AnyObject {
    func registerByPhoneNumber(request: RegisterRequest)
}

protocol DisplayLogic: AnyObject {
    func presentingRegister(viewModel: RegisterViewModel)
    func startLoading()
    func finishLoading()
    func showError(errorDescription: String)
}

class RegisterPresenter: RegisterViewInput {
    
    weak var viewController: DisplayLogic?
    var interactor: RegisterBusinessLogic!
    
    func registerByPhoneNumber(request: RegisterRequest) {
        Task {
            do {
                viewController?.startLoading()
                let interactorResult = try await interactor.sendPhoneNumber(reguest: request)
                viewController?.finishLoading()
                let viewModel = RegisterViewModel(smsCode: interactorResult.result.smsCode, clientRegisterID: interactorResult.result.clientRegisterID)
                viewController?.presentingRegister(viewModel: viewModel)
                
            } catch {
                viewController?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
}
