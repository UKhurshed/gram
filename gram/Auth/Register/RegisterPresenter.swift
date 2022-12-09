//
//  RegisterPresenter.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import Foundation

protocol RegisterPresentationLogic: AnyObject {
    func presentingRegister(response: RegisterResponse)
}


class RegisterPresenter: RegisterPresentationLogic {
    
    weak var viewController: RegisterDisplayLogic?
    
    func presentingRegister(response: RegisterResponse) {
        print("response: \(response)")
        let viewModel = RegisterViewModel(smsCode: response.result.smsCode, clientRegisterID: response.result.clientRegisterID)
        viewController?.presentingRegister(viewModel: viewModel)
    }
    
}
