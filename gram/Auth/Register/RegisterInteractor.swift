//
//  RegisterInteractor.swift
//  gram
//
//  Created by Khurshed Umarov on 08.12.2022.
//

import UIKit

protocol RegisterBusinessLogic: AnyObject {
    func sendPhoneNumber(reguest: RegisterRequest)
}

class RegisterInteractor: RegisterBusinessLogic {
    
    var presenter: RegisterPresentationLogic?
    var service: RegisterService?
    
    func sendPhoneNumber(reguest: RegisterRequest) {
        service = RegisterService()
        print("Request from interactor: \(reguest.phoneNumber)")
        let result = service?.registerUser() ?? ""
        presenter?.presentingRegister(response: RegisterResponse(success: true, code: 200, message: result, result: ResultResponse(smsCode: result, clientRegisterID: result), error: []))
    }
}

